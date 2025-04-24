package repositories

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/services"
	"context"
	"fmt"

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

func (r *ContestRepository) GetAllContests(ctx context.Context) ([]domain.Contest, error) {
	
	contests, err := services.FetchContestsFromCodeforces()
	if err != nil {
		return nil, err
	}

	
	for i := range contests {
		if err := r.db.WithContext(ctx).Create(&contests[i]).Error; err != nil {
			return nil, fmt.Errorf("error saving contest %d: %w", contests[i].ID, err)
		}
	}

	return contests, nil
}

func (r *ContestRepository) GetContestByID(ctx context.Context, id int) (domain.Contest, error) {
	var contest domain.Contest
	if err := r.db.WithContext(ctx).First(&contest, id).Error; err != nil {
		return domain.Contest{}, err
	}

	
	return contest, nil
}
