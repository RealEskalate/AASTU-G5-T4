package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
	"math"
)

type ContestUseCase struct {
	repo domain.ContestRepository
}

func NewContestUseCase(repo domain.ContestRepository) *ContestUseCase {
	return &ContestUseCase{repo: repo}
}

func (u *ContestUseCase) GetAllContests(ctx context.Context) ([]domain.Contest, error) {
	contests, err := u.repo.GetAllContests(ctx)
	if err != nil {
		return nil, err
	}

	return contests, nil
}

func (u *ContestUseCase) GetContestByID(ctx context.Context, id int) (*domain.Contest, error) {
	contest, err := u.repo.GetContestByID(ctx, id)
	if err != nil {
		return nil, err
	}

	return &contest, nil
}

func (u *ContestUseCase) AddContest(ctx context.Context, name, link string) (int, error) {
	contest := domain.Contest{
		Name:   name,
		Link:   link,
		Rating: 1, 
	}

	err := u.repo.SaveContest(ctx, &contest)
	if err != nil {
		return 0, err
	}

	return contest.ID, nil
}

func (u *ContestUseCase) GetStandings(ctx context.Context, contestID int) (*domain.StandingsResponse, error) {
	return u.repo.GetStandings(ctx, contestID)
}


func calculateELO(currentRating, opponentRating float64, score float64) float64 {
	const kFactor = 32 

	
	expectedScore := 1 / (1 + math.Pow(10, (opponentRating-currentRating)/400))

	
	newRating := currentRating + kFactor*(score-expectedScore)

	return newRating
}


func (u *ContestUseCase) UpdateRatings(ctx context.Context, contestID int, standings *domain.StandingsResponse) error {
	
	ratings, err := u.repo.GetAllRatings(ctx, contestID)
	if err != nil {
		return err
	}

	
	userRatings := make(map[int]float64)
	for _, rating := range ratings {
		userRatings[rating.UserID] = float64(rating.Points)
	}

	
	for i, row := range standings.Result.Rows {
		if len(row.Party.Members) == 0 {
			continue
		}

		userID := row.Party.Members[0].ID
		currentRating := userRatings[userID]

	
		score := 1.0 - (float64(i) / float64(len(standings.Result.Rows)))

		
		var totalOpponentRating float64
		var opponentCount int
		for j, otherRow := range standings.Result.Rows {
			if i == j || len(otherRow.Party.Members) == 0 {
				continue
			}
			otherUserID := otherRow.Party.Members[0].ID
			totalOpponentRating += userRatings[otherUserID]
			opponentCount++
		}

		if opponentCount > 0 {
			averageOpponentRating := totalOpponentRating / float64(opponentCount)
			newRating := calculateELO(currentRating, averageOpponentRating, score)

			
			if err := u.repo.UpdateRating(ctx, contestID, userID, int(newRating)); err != nil {
				return err
			}
		}
	}

	return nil
}
