package usecases

import (
	"context"
	"fmt"
	"math"
	"time"

	"A2SVHUB/internal/domain"
)

type ContestUseCase struct {
	repo   domain.ContestRepository
	cache  domain.CacheRepository
	client domain.ContestClient
}

func NewContestUseCase(repo domain.ContestRepository, cache domain.CacheRepository, client domain.ContestClient) *ContestUseCase {
	return &ContestUseCase{
		repo:   repo,
		cache:  cache,
		client: client,
	}
}

func (u *ContestUseCase) GetAllContests(ctx context.Context) ([]*domain.Contest, error) {
	contests, err := u.repo.GetAllContests(ctx)
	if err != nil {
		return nil, err
	}

	contestPtrs := make([]*domain.Contest, len(contests))
	for i := range contests {
		contestPtrs[i] = &contests[i]
	}
	return contestPtrs, nil
}

func (u *ContestUseCase) GetContestByID(ctx context.Context, id int) (*domain.Contest, error) {
	contest, err := u.repo.GetContestByID(ctx, id)
	if err != nil {
		return nil, err
	}

	return &contest, nil
}

func (u *ContestUseCase) AddContest(ctx context.Context, contest *domain.Contest) error {
	err := u.repo.SaveContest(ctx, contest)
	if err != nil {
		return err
	}
	return nil
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

func (cu *ContestUseCase) SaveStandings(ctx context.Context, contestID int, standings *domain.StandingsResponse) error {
	// Validate contest exists
	_, err := cu.repo.GetContestByID(ctx, contestID)
	if err != nil {
		return err
	}

	// Save standings to database
	err = cu.repo.SaveStandings(ctx, contestID, standings)
	if err != nil {
		return fmt.Errorf("failed to save standings to database: %w", err)
	}

	// Save standings in cache
	err = cu.cache.Set(fmt.Sprintf("standings:%d", contestID), standings, 24*time.Hour)
	if err != nil {
		return fmt.Errorf("failed to save standings to cache: %w", err)
	}

	return nil
}

func (cu *ContestUseCase) ClearStandingsCache(ctx context.Context, contestID int) error {
	// Validate contest exists
	_, err := cu.repo.GetContestByID(ctx, contestID)
	if err != nil {
		return err
	}

	// Delete standings from cache
	err = cu.cache.Delete(fmt.Sprintf("standings:%d", contestID))
	if err != nil {
		return fmt.Errorf("failed to clear standings cache: %w", err)
	}

	return nil
}
