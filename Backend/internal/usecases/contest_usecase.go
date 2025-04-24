package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
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

