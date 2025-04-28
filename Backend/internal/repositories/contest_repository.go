package repositories

import (
	"A2SVHUB/internal/domain"
	"context"
	"crypto/sha512"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"math/rand"
	"net/http"
	"net/url"
	"os"
	"sort"
	"strings"
	"time"

	"gorm.io/gorm"
)

type ContestRepository struct {
	db gorm.DB
}

func NewContestRepository(db gorm.DB) domain.ContestRepository {
	return &ContestRepository{
		db: db,
	}
}

func calculateRating(problemCount int) int {
	switch {
	case problemCount >= 10:
		return 5
	case problemCount >= 7:
		return 4
	case problemCount >= 4:
		return 3
	case problemCount >= 2:
		return 2
	default:
		return 1
	}
}

func (r *ContestRepository) generateSignature(method string, params map[string]string) string {
	rand.Seed(time.Now().UnixNano())
	randNum := fmt.Sprintf("%06d", rand.Intn(1000000))

	// Add API key and time to params
	params["apiKey"] = os.Getenv("CODEFORCES_API_KEY")
	params["time"] = fmt.Sprintf("%d", time.Now().Unix())

	var keys []string
	for k := range params {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	query := method + "?"
	for i, k := range keys {
		if i > 0 {
			query += "&"
		}
		query += fmt.Sprintf("%s=%s", k, url.QueryEscape(params[k]))
	}
	query += "#" + os.Getenv("CODEFORCES_API_SECRET")

	hash := sha512.Sum512([]byte(randNum + "/" + query))
	return randNum + hex.EncodeToString(hash[:])
}

func (r *ContestRepository) validateAPICredentials() error {
	apiKey := os.Getenv("CODEFORCES_API_KEY")
	apiSecret := os.Getenv("CODEFORCES_API_SECRET")

	if apiKey == "" || apiSecret == "" {
		return fmt.Errorf("missing Codeforces API credentials. Please set CODEFORCES_API_KEY and CODEFORCES_API_SECRET environment variables")
	}
	return nil
}

func (r *ContestRepository) SaveStandings(ctx context.Context, contestID int, standings *domain.StandingsResponse) error {
	// Convert standings to JSON
	standingsJSON, err := json.Marshal(standings)
	if err != nil {
		return fmt.Errorf("error marshaling standings: %w", err)
	}

	// Create or update standings
	standing := domain.ContestStanding{
		ContestID: contestID,
		Data:      string(standingsJSON),
		UpdatedAt: time.Now(),
	}

	// Try to find existing standing
	var existingStanding domain.ContestStanding
	result := r.db.WithContext(ctx).Where("contest_id = ?", contestID).First(&existingStanding)

	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			// Create new standing
			standing.CreatedAt = time.Now()
			if err := r.db.WithContext(ctx).Create(&standing).Error; err != nil {
				return fmt.Errorf("error creating standings: %w", err)
			}
		} else {
			return fmt.Errorf("error checking existing standings: %w", result.Error)
		}
	} else {
		// Update existing standing
		if err := r.db.WithContext(ctx).Model(&existingStanding).Updates(map[string]interface{}{
			"data":       standing.Data,
			"updated_at": standing.UpdatedAt,
		}).Error; err != nil {
			return fmt.Errorf("error updating standings: %w", err)
		}
	}

	return nil
}

func (r *ContestRepository) GetStandings(ctx context.Context, contestID int) (*domain.StandingsResponse, error) {
	// First try to get from database
	var standing domain.ContestStanding
	result := r.db.WithContext(ctx).Where("contest_id = ?", contestID).First(&standing)

	if result.Error == nil {
		// Found in database, unmarshal and return
		var standings domain.StandingsResponse
		if err := json.Unmarshal([]byte(standing.Data), &standings); err != nil {
			return nil, fmt.Errorf("error unmarshaling standings from database: %w", err)
		}
		return &standings, nil
	}

	// Not found in database or error occurred, fetch from API
	if err := r.validateAPICredentials(); err != nil {
		return nil, err
	}

	// Get the contest to check if it's a group contest
	var contest domain.Contest
	if err := r.db.WithContext(ctx).
		Preload("SuperGroup").
		First(&contest, contestID).Error; err != nil {
		return nil, fmt.Errorf("error fetching contest: %w", err)
	}

	method := "contest.standings"
	params := make(map[string]string)
	params["contestId"] = fmt.Sprintf("%d", contestID)
	params["from"] = "1"
	params["count"] = "10000"
	params["showUnofficial"] = "true"

	// Add group ID if it's a group contest
	if contest.SuperGroupID != 0 {
		// Get the SuperToGroup relationship
		var superToGroup domain.SuperToGroup
		if err := r.db.WithContext(ctx).
			Where("super_group_id = ?", contest.SuperGroupID).
			First(&superToGroup).Error; err == nil {
			// Only add groupId if we found a valid SuperToGroup relationship
			params["groupId"] = fmt.Sprintf("%d", superToGroup.GroupID)
		}
	}

	signature := r.generateSignature(method, params)
	params["apiSig"] = signature

	baseURL := fmt.Sprintf("https://codeforces.com/api/%s", method)
	reqURL, _ := url.Parse(baseURL)
	query := reqURL.Query()
	for k, v := range params {
		query.Set(k, v)
	}
	reqURL.RawQuery = query.Encode()

	resp, err := http.Get(reqURL.String())
	if err != nil {
		return nil, fmt.Errorf("failed to fetch standings: %w", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading standings response body: %w", err)
	}

	if strings.Contains(string(body), "<!DOCTYPE html>") {
		return nil, fmt.Errorf("received HTML error page from Codeforces API")
	}

	var standings domain.StandingsResponse
	if err := json.Unmarshal(body, &standings); err != nil {
		// Check if it's a Codeforces API error response
		var apiError struct {
			Status  string `json:"status"`
			Comment string `json:"comment"`
		}
		if jsonErr := json.Unmarshal(body, &apiError); jsonErr == nil && apiError.Status == "FAILED" {
			return nil, fmt.Errorf("codeforces API error: %s", apiError.Comment)
		}
		return nil, fmt.Errorf("error unmarshaling standings response: %w", err)
	}

	if standings.Status != "OK" {
		return nil, fmt.Errorf("codeforces returned status: %s", standings.Status)
	}

	// Sort rows by points and penalty
	sort.Slice(standings.Result.Rows, func(i, j int) bool {
		if standings.Result.Rows[i].Points == standings.Result.Rows[j].Points {
			return standings.Result.Rows[i].Penalty < standings.Result.Rows[j].Penalty
		}
		return standings.Result.Rows[i].Points > standings.Result.Rows[j].Points
	})

	// Update ranks
	for i := range standings.Result.Rows {
		standings.Result.Rows[i].Rank = i + 1
	}

	// Save to database
	if err := r.SaveStandings(ctx, contestID, &standings); err != nil {
		fmt.Printf("Warning: failed to save standings to database: %v\n", err)
	}

	return &standings, nil
}

func (r *ContestRepository) GetAllContests(ctx context.Context) ([]domain.Contest, error) {
	var contests []domain.Contest

	if err := r.db.WithContext(ctx).
		Preload("Ratings").
		Preload("Ratings.User").
		Find(&contests).Error; err != nil {
		return nil, fmt.Errorf("error fetching contests from database: %w", err)
	}

	fmt.Printf("Found %d contests in database\n", len(contests))

	// Process each contest
	for i := range contests {
		standings, err := r.GetStandings(ctx, contests[i].ID)
		if err != nil {
			fmt.Printf("Warning: error fetching standings for contest %d: %v\n", contests[i].ID, err)
			continue
		}

		contests[i].Standings = standings

		// Map to store user performance
		type UserPerformance struct {
			UserID  int
			Solved  int
			Penalty int
			Score   float64
			Handle  string
		}

		var performances []UserPerformance
		for _, row := range standings.Result.Rows {
			if len(row.Party.Members) == 0 {
				continue
			}

			handle := row.Party.Members[0].Handle

			var userID int
			for _, rating := range contests[i].Ratings {
				if rating.User.Codeforces == "https://codeforces.com/profile/"+handle {
					userID = rating.UserID
					break
				}
			}
			if userID == 0 {
				continue
			}

			solved := 0
			totalPenalty := 0
			for _, result := range row.ProblemResults {
				if result.Points > 0 {
					solved++
					totalPenalty += result.RejectedAttemptCount * 10
				}
			}

			score := float64(solved * 100)
			score -= float64(totalPenalty * 2)

			performances = append(performances, UserPerformance{
				UserID:  userID,
				Solved:  solved,
				Penalty: totalPenalty,
				Score:   score,
				Handle:  handle,
			})
		}

		// Sort performances by score and penalty
		sort.Slice(performances, func(i, j int) bool {
			if performances[i].Score == performances[j].Score {
				return performances[i].Penalty < performances[j].Penalty
			}
			return performances[i].Score > performances[j].Score
		})

		
		const (
			initialRating = 1400
			kFactor       = 32
		)

		for j, perf := range performances {
			expectedScore := 1.0 - (float64(j) / float64(len(performances)))
			actualScore := perf.Score / 100.0
			ratingChange := int(kFactor * (actualScore - expectedScore))
			finalRating := initialRating + ratingChange

			// Update the rating in the contest
			for k := range contests[i].Ratings {
				if contests[i].Ratings[k].UserID == perf.UserID {
					contests[i].Ratings[k].Points = finalRating
					contests[i].Ratings[k].Rank = j + 1
					contests[i].Ratings[k].Solved = perf.Solved
					contests[i].Ratings[k].Penalty = perf.Penalty
					contests[i].Ratings[k].Gain = ratingChange

					// Update the rating in the database
					if err := r.UpdateRating(ctx, contests[i].ID, perf.UserID, finalRating); err != nil {
						fmt.Printf("Warning: error updating rating for user %d in contest %d: %v\n",
							perf.UserID, contests[i].ID, err)
					}
					break
				}
			}
		}
	}

	// Sort contests by ID in descending order
	sort.Slice(contests, func(i, j int) bool {
		return contests[i].ID > contests[j].ID
	})

	return contests, nil
}

func (r *ContestRepository) fetchContestProblems(ctx context.Context, contest *domain.Contest) error {
	// Prepare API request parameters
	params := make(map[string]string)
	params["contestId"] = fmt.Sprintf("%d", contest.ID)

	// Generate API signature
	signature := r.generateSignature("contest.standings", params)
	params["apiSig"] = signature
	params["apiKey"] = os.Getenv("CODEFORCES_API_KEY")
	params["time"] = fmt.Sprintf("%d", time.Now().Unix())

	// Build request URL
	baseURL := "https://codeforces.com/api/contest.standings"
	reqURL, _ := url.Parse(baseURL)
	query := reqURL.Query()
	for k, v := range params {
		query.Set(k, v)
	}
	reqURL.RawQuery = query.Encode()

	// Make the request
	resp, err := http.Get(reqURL.String())
	if err != nil {
		return fmt.Errorf("failed to fetch contest problems: %w", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("error reading response body: %w", err)
	}

	var response struct {
		Status string `json:"status"`
		Result struct {
			Problems []struct {
				ContestID int      `json:"contestId"`
				Index     string   `json:"index"`
				Name      string   `json:"name"`
				Type      string   `json:"type"`
				Rating    int      `json:"rating"`
				Tags      []string `json:"tags"`
			} `json:"problems"`
		} `json:"result"`
	}

	if err := json.Unmarshal(body, &response); err != nil {
		return fmt.Errorf("error unmarshaling response: %w", err)
	}

	if response.Status != "OK" {
		return fmt.Errorf("API returned non-OK status: %s", response.Status)
	}

	// Update contest problems
	contest.Problems = response.Result.Problems
	contest.ProblemCount = len(response.Result.Problems)

	return nil
}

func (r *ContestRepository) GetContestStandings(ctx context.Context, contestID int) (*domain.StandingsResponse, error) {
	var contest domain.Contest
	if err := r.db.WithContext(ctx).
		Preload("Ratings").
		Preload("Ratings.User").
		First(&contest, contestID).Error; err != nil {
		return nil, fmt.Errorf("error fetching contest: %w", err)
	}

	standings := &domain.StandingsResponse{
		Status: "OK",
		Result: struct {
			Contest struct {
				ID   int    `json:"id"`
				Name string `json:"name"`
				Type string `json:"type"`
			} `json:"contest"`
			Problems []struct {
				Index string   `json:"index"`
				Name  string   `json:"name"`
				Tags  []string `json:"tags"`
			} `json:"problems"`
			Rows []struct {
				Party struct {
					Members []struct {
						Handle string `json:"handle"`
						ID     int    `json:"id"`
					} `json:"members"`
				} `json:"party"`
				Rank           int     `json:"rank"`
				Points         float64 `json:"points"`
				Penalty        int     `json:"penalty"`
				ProblemResults []struct {
					Points                    float64 `json:"points"`
					RejectedAttemptCount      int     `json:"rejectedAttemptCount"`
					Type                      string  `json:"type"`
					BestSubmissionTimeSeconds int     `json:"bestSubmissionTimeSeconds"`
				} `json:"problemResults"`
			} `json:"rows"`
		}{
			Contest: struct {
				ID   int    `json:"id"`
				Name string `json:"name"`
				Type string `json:"type"`
			}{
				ID:   contest.ID,
				Name: contest.Name,
				Type: contest.Type,
			},
		},
	}

	var ratings []domain.Rating
	if err := r.db.WithContext(ctx).
		Preload("User").
		Where("contest_id = ?", contestID).
		Find(&ratings).Error; err != nil {
		return nil, fmt.Errorf("error fetching ratings: %w", err)
	}

	sort.Slice(ratings, func(i, j int) bool {
		if ratings[i].Points == ratings[j].Points {
			return ratings[i].Penalty < ratings[j].Penalty
		}
		return ratings[i].Points > ratings[j].Points
	})

	for i, rating := range ratings {
		if rating.User.Codeforces == "" {
			continue
		}

		handle := strings.TrimPrefix(rating.User.Codeforces, "https://codeforces.com/profile/")
		if handle == "" {
			continue
		}

		row := struct {
			Party struct {
				Members []struct {
					Handle string `json:"handle"`
					ID     int    `json:"id"`
				} `json:"members"`
			} `json:"party"`
			Rank           int     `json:"rank"`
			Points         float64 `json:"points"`
			Penalty        int     `json:"penalty"`
			ProblemResults []struct {
				Points                    float64 `json:"points"`
				RejectedAttemptCount      int     `json:"rejectedAttemptCount"`
				Type                      string  `json:"type"`
				BestSubmissionTimeSeconds int     `json:"bestSubmissionTimeSeconds"`
			} `json:"problemResults"`
		}{
			Party: struct {
				Members []struct {
					Handle string `json:"handle"`
					ID     int    `json:"id"`
				} `json:"members"`
			}{
				Members: []struct {
					Handle string `json:"handle"`
					ID     int    `json:"id"`
				}{
					{
						Handle: handle,
						ID:     rating.UserID,
					},
				},
			},
			Rank:    i + 1,
			Points:  float64(rating.Points),
			Penalty: rating.Penalty,
		}

		standings.Result.Rows = append(standings.Result.Rows, row)
	}

	return standings, nil
}

func (r *ContestRepository) GetContestByID(ctx context.Context, id int) (domain.Contest, error) {
	var contest domain.Contest
	if err := r.db.WithContext(ctx).
		Preload("Ratings").
		Preload("Ratings.User").
		First(&contest, id).Error; err != nil {
		return domain.Contest{}, err
	}

	standings, err := r.GetStandings(ctx, contest.ID)
	if err != nil {
		return contest, fmt.Errorf("error fetching standings: %w", err)
	}

	type UserPerformance struct {
		UserID  int
		Solved  int
		Penalty int
		Score   float64
		Handle  string
	}

	var performances []UserPerformance
	for _, row := range standings.Result.Rows {
		if len(row.Party.Members) == 0 {
			continue
		}

		handle := row.Party.Members[0].Handle

		var userID int
		for _, rating := range contest.Ratings {
			if rating.User.Codeforces == "https://codeforces.com/profile/"+handle {
				userID = rating.UserID
				break
			}
		}
		if userID == 0 {
			continue
		}

		solved := 0
		totalPenalty := 0
		for _, result := range row.ProblemResults {
			if result.Points > 0 {
				solved++
				totalPenalty += result.RejectedAttemptCount * 10
			}
		}

		score := float64(solved * 100)
		score -= float64(totalPenalty * 2)

		performances = append(performances, UserPerformance{
			UserID:  userID,
			Solved:  solved,
			Penalty: totalPenalty,
			Score:   score,
			Handle:  handle,
		})
	}

	sort.Slice(performances, func(i, j int) bool {
		if performances[i].Score == performances[j].Score {
			return performances[i].Penalty < performances[j].Penalty
		}
		return performances[i].Score > performances[j].Score
	})

	const (
		initialRating = 1400
		kFactor       = 32
	)

	for j, perf := range performances {

		expectedScore := 1.0 - (float64(j) / float64(len(performances)))

		actualScore := perf.Score / 100.0

		ratingChange := int(kFactor * (actualScore - expectedScore))

		finalRating := initialRating + ratingChange

		for k := range contest.Ratings {
			if contest.Ratings[k].UserID == perf.UserID {
				contest.Ratings[k].Points = finalRating
				contest.Ratings[k].Rank = j + 1
				contest.Ratings[k].Solved = perf.Solved
				contest.Ratings[k].Penalty = perf.Penalty
				contest.Ratings[k].Gain = ratingChange
				break
			}
		}
	}

	contest.Standings = standings
	return contest, nil
}

func (r *ContestRepository) SaveContest(ctx context.Context, contest *domain.Contest) error {
	var contestID int
	if strings.Contains(contest.Link, "/contest/") {
		if strings.Contains(contest.Link, "/group/") {
			// Handle group contest URLs
			parts := strings.Split(contest.Link, "/contest/")
			if len(parts) != 2 {
				return fmt.Errorf("invalid group contest URL format: %s", contest.Link)
			}
			_, err := fmt.Sscanf(parts[1], "%d", &contestID)
			if err != nil {
				return fmt.Errorf("invalid group contest ID format: %s", contest.Link)
			}
		} else {
			
			_, err := fmt.Sscanf(contest.Link, "https://codeforces.com/contest/%d", &contestID)
			if err != nil {
				return fmt.Errorf("invalid contest URL format: %s", contest.Link)
			}
		}
	} else if strings.Contains(contest.Link, "/gym/") {
		
		_, err := fmt.Sscanf(contest.Link, "https://codeforces.com/gym/%d", &contestID)
		if err != nil {
			return fmt.Errorf("invalid gym URL format: %s", contest.Link)
		}
	} else {
		return fmt.Errorf("URL must contain either /contest/, /gym/, or /group/.../contest/: %s", contest.Link)
	}
	contest.ID = contestID

	tx := r.db.WithContext(ctx).Begin()
	if tx.Error != nil {
		return tx.Error
	}

	
	if err := tx.Create(contest).Error; err != nil {
		tx.Rollback()
		return err
	}

	
	if err := tx.Commit().Error; err != nil {
		return fmt.Errorf("error committing contest: %w", err)
	}

	
	tx = r.db.WithContext(ctx).Begin()
	if tx.Error != nil {
		return tx.Error
	}

	var users []domain.User
	if err := tx.Where("codeforces IS NOT NULL AND codeforces != ''").Find(&users).Error; err != nil {
		tx.Rollback()
		return fmt.Errorf("error fetching users: %w", err)
	}

	standings, err := r.GetStandings(ctx, contest.ID)
	if err != nil {
		tx.Rollback()
		return fmt.Errorf("error fetching standings: %w", err)
	}

	handleToUserID := make(map[string]int)
	for _, user := range users {
		handle := strings.TrimPrefix(user.Codeforces, "https://codeforces.com/profile/")
		handleToUserID[handle] = user.ID
	}

	type UserPerformance struct {
		UserID  int
		Solved  int
		Penalty int
		Score   float64
		Handle  string
	}

	var performances []UserPerformance
	for _, row := range standings.Result.Rows {
		if len(row.Party.Members) == 0 {
			continue
		}

		handle := row.Party.Members[0].Handle
		userID, exists := handleToUserID[handle]
		if !exists {
			continue
		}

		solved := 0
		totalPenalty := 0
		for _, result := range row.ProblemResults {
			if result.Points > 0 {
				solved++
				totalPenalty += result.RejectedAttemptCount * 10
			}
		}

		score := float64(solved * 100)
		score -= float64(totalPenalty * 2)

		performances = append(performances, UserPerformance{
			UserID:  userID,
			Solved:  solved,
			Penalty: totalPenalty,
			Score:   score,
			Handle:  handle,
		})
	}

	sort.Slice(performances, func(i, j int) bool {
		if performances[i].Score == performances[j].Score {
			return performances[i].Penalty < performances[j].Penalty
		}
		return performances[i].Score > performances[j].Score
	})

	const (
		initialRating = 1400
		kFactor       = 32
	)

	for i, perf := range performances {
		expectedScore := 1.0 - (float64(i) / float64(len(performances)))
		actualScore := perf.Score / 100.0
		ratingChange := int(kFactor * (actualScore - expectedScore))
		finalRating := initialRating + ratingChange

		rating := domain.Rating{
			ContestID: contest.ID,
			UserID:    perf.UserID,
			Rank:      i + 1,
			Penalty:   perf.Penalty,
			Solved:    perf.Solved,
			Points:    finalRating,
			Gain:      ratingChange,
			CreatedAt: time.Now(),
			UpdatedAt: time.Now(),
		}

		if err := tx.Create(&rating).Error; err != nil {
			tx.Rollback()
			return fmt.Errorf("error creating rating for user %d: %w", perf.UserID, err)
		}
	}

	if err := tx.Commit().Error; err != nil {
		return fmt.Errorf("error committing ratings: %w", err)
	}

	return nil
}

func (r *ContestRepository) GetAllRatings(ctx context.Context, contestID int) ([]domain.Rating, error) {
	var ratings []domain.Rating
	if err := r.db.WithContext(ctx).Where("contest_id = ?", contestID).Find(&ratings).Error; err != nil {
		return nil, fmt.Errorf("error fetching ratings: %w", err)
	}
	return ratings, nil
}

func (r *ContestRepository) UpdateRating(ctx context.Context, contestID, userID, newRating int) error {
	result := r.db.WithContext(ctx).Model(&domain.Rating{}).
		Where("contest_id = ? AND user_id = ?", contestID, userID).
		Update("points", newRating)

	if result.Error != nil {
		return fmt.Errorf("error updating rating: %w", result.Error)
	}
	return nil
}
