package repositories

import (
    "A2SVHUB/internal/domain"
    "context"

    "gorm.io/gorm"
)

type DailyProblemRepository struct {
    db *gorm.DB
}

// CreateDailyProblem creates a new daily problem in the database.
func (r *DailyProblemRepository) CreateDailyProblem(ctx context.Context, dailyProblem domain.DailyProblem) (domain.DailyProblem, error) {
    if err := r.db.WithContext(ctx).Create(&dailyProblem).Error; err != nil {
        return domain.DailyProblem{}, err
    }
    return dailyProblem, nil
}

// GetDailyProblemByID retrieves a daily problem by its ID.
func (r *DailyProblemRepository) GetDailyProblemByID(ctx context.Context, id int) (domain.DailyProblem, error) {
    var dailyProblem domain.DailyProblem
    if err := r.db.WithContext(ctx).First(&dailyProblem, id).Error; err != nil {
        if err == gorm.ErrRecordNotFound {
            return domain.DailyProblem{}, gorm.ErrRecordNotFound
        }
        return domain.DailyProblem{}, err
    }
    return dailyProblem, nil
}

// GetDailyProblemsByDate retrieves all daily problems for a specific date.
func (r *DailyProblemRepository) GetDailyProblemsByDate(ctx context.Context, date string) ([]domain.DailyProblem, error) {
    var dailyProblems []domain.DailyProblem
    if err := r.db.WithContext(ctx).Where("for_date = ?", date).Find(&dailyProblems).Error; err != nil {
        return nil, err
    }
    return dailyProblems, nil
}

// UpdateDailyProblem updates an existing daily problem.
func (r *DailyProblemRepository) UpdateDailyProblem(ctx context.Context, dailyProblem domain.DailyProblem) error {
    if err := r.db.WithContext(ctx).Save(&dailyProblem).Error; err != nil {
        return err
    }
    return nil
}

// DeleteDailyProblem deletes a daily problem by its ID.
func (r *DailyProblemRepository) DeleteDailyProblem(ctx context.Context, id int) error {
    if err := r.db.WithContext(ctx).Delete(&domain.DailyProblem{}, id).Error; err != nil {
        return err
    }
    return nil
}

// NewDailyProblemRepository creates a new instance of DailyProblemRepository.
func NewDailyProblemRepository(db *gorm.DB) domain.DailyProblemRepository {
    return &DailyProblemRepository{
        db: db,
    }
}