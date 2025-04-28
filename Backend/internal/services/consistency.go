package services

import (
	"A2SVHUB/internal/repositories"
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strconv"
	"strings"
	"time"

	"gorm.io/gorm"
)

func GetTotalDailySubmissions(ctx context.Context, db gorm.DB) (int, int, error) {

	// Get all users
	userRepo := repositories.NewUserRepository(db)
	users, err := userRepo.GetAllUsers(ctx)
	if err != nil {
		return 0, 0, fmt.Errorf("failed to get users: %w", err)
	}

	totalLeetcodeSubs := 0
	totalCodeforcesSubs := 0

	// Process each user
	for _, user := range users {
		// Get LeetCode submissions if URL exists
		if user.Leetcode != "" {
			leetcodeSubs, err := LeetCodeConsistency(user.Leetcode)
			if err != nil {
				// Log error but continue with other users
				fmt.Printf("Error getting LeetCode submissions for user %s: %v\n", user.ID, err)
				continue
			}
			totalLeetcodeSubs += leetcodeSubs
		}

		// Get Codeforces submissions if URL exists
		if user.Codeforces != "" {
			codeforcesSubs, err := CodeforcesConsistency(user.Codeforces)
			if err != nil {
				// Log error but continue with other users
				fmt.Printf("Error getting Codeforces submissions for user %s: %v\n", user.ID, err)
				continue
			}
			totalCodeforcesSubs += codeforcesSubs
		}
	}

	return totalLeetcodeSubs, totalCodeforcesSubs, nil
}

// LeetCodeConsistency gets the number of LeetCode submissions made today
func LeetCodeConsistency(url string) (int, error) {
	// Extract username from URL
	if !strings.HasPrefix(url, "https://leetcode.com/") && !strings.HasPrefix(url, "http://leetcode.com/") {
		return 0, fmt.Errorf("invalid LeetCode URL format")
	}

	parts := strings.Split(strings.Trim(url, "/"), "/")
	username := parts[len(parts)-1]
	if username == "" {
		return 0, fmt.Errorf("username not found in URL")
	}

	// GraphQL query
	query := fmt.Sprintf(`{
		"query": "query getUserProfile($username: String!) { matchedUser(username: $username) { submitStats { submissionCalendar } } }",
		"variables": {"username": "%s"}
	}`, username)

	req, err := http.NewRequest("POST", "https://leetcode.com/graphql", strings.NewReader(query))
	if err != nil {
		return 0, err
	}

	req.Header.Set("Content-Type", "application/json")
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return 0, err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return 0, err
	}

	var result struct {
		Data struct {
			MatchedUser struct {
				SubmitStats struct {
					SubmissionCalendar string `json:"submissionCalendar"`
				} `json:"submitStats"`
			} `json:"matchedUser"`
		} `json:"data"`
	}

	err = json.Unmarshal(body, &result)
	if err != nil {
		return 0, err
	}

	// Parse submission calendar
	var calendar map[string]int
	err = json.Unmarshal([]byte(result.Data.MatchedUser.SubmitStats.SubmissionCalendar), &calendar)
	if err != nil {
		return 0, err
	}

	// Get today's timestamp
	now := time.Now()
	today := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, time.UTC)
	todayTimestamp := strconv.FormatInt(today.Unix(), 10)

	return calendar[todayTimestamp], nil
}

// CodeforcesConsistency gets the number of Codeforces submissions made today
func CodeforcesConsistency(url string) (int, error) {
	// Extract handle from URL
	if !strings.HasPrefix(url, "https://codeforces.com/profile/") &&
		!strings.HasPrefix(url, "http://codeforces.com/profile/") {
		return 0, fmt.Errorf("invalid Codeforces URL format")
	}

	parts := strings.Split(strings.Trim(url, "/"), "/")
	handle := parts[len(parts)-1]
	if handle == "" {
		return 0, fmt.Errorf("handle not found in URL")
	}

	// Get current time in Codeforces timezone (UTC+3)
	loc, _ := time.LoadLocation("Europe/Moscow")
	now := time.Now().In(loc)
	from := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, loc).Unix()
	to := from + 86400 // Add 24 hours

	apiUrl := fmt.Sprintf("https://codeforces.com/api/user.status?handle=%s&from=1&count=100", handle)
	resp, err := http.Get(apiUrl)
	if err != nil {
		return 0, err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return 0, err
	}

	var result struct {
		Status string `json:"status"`
		Result []struct {
			CreationTimeSeconds int64 `json:"creationTimeSeconds"`
		} `json:"result"`
	}

	err = json.Unmarshal(body, &result)
	if err != nil {
		return 0, err
	}

	if result.Status != "OK" {
		return 0, fmt.Errorf("API request failed")
	}

	// Count submissions from today
	count := 0
	for _, submission := range result.Result {
		if submission.CreationTimeSeconds >= from && submission.CreationTimeSeconds < to {
			count++
		}
	}

	return count, nil
}
