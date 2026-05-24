package usecases

import (
    "A2SVHUB/internal/domain"
    "context"
    "errors"
)

type DailyProblemUseCase struct {
    DailyProblemRepository domain.DailyProblemRepository
}

// CreateDailyProblem creates a new daily problem.
func (uc DailyProblemUseCase) CreateDailyProblem(ctx context.Context, dailyProblem domain.DailyProblem) (domain.DailyProblem, error) {
    // Perform validation
    if dailyProblem.ProblemID == 0 {
        return domain.DailyProblem{}, errors.New("problem ID cannot be zero")
    }
    if dailyProblem.SuperGroupID == 0 {
        return domain.DailyProblem{}, errors.New("super group ID cannot be zero")
    }
    if dailyProblem.ForDate.IsZero() {
        return domain.DailyProblem{}, errors.New("for date cannot be empty")
    }

    // Call the repository to create the daily problem
    return uc.DailyProblemRepository.CreateDailyProblem(ctx, dailyProblem)
}

// GetDailyProblemByID retrieves a daily problem by its ID.
func (uc DailyProblemUseCase) GetDailyProblemByID(ctx context.Context, id int) (domain.DailyProblem, error) {
    // Call the repository to fetch the daily problem by ID
    dailyProblem, err := uc.DailyProblemRepository.GetDailyProblemByID(ctx, id)
    if err != nil {
        return domain.DailyProblem{}, errors.New("daily problem not found")
    }
    return dailyProblem, nil
}

// GetDailyProblemsByDate retrieves all daily problems for a specific date.
func (uc DailyProblemUseCase) GetDailyProblemsByDate(ctx context.Context, date string) ([]domain.DailyProblem, error) {
    // Call the repository to fetch daily problems by date
    dailyProblems, err := uc.DailyProblemRepository.GetDailyProblemsByDate(ctx, date)
    if err != nil {
        return nil, err
    }
    return dailyProblems, nil
}

// UpdateDailyProblem updates an existing daily problem.
func (uc DailyProblemUseCase) UpdateDailyProblem(ctx context.Context, id int, dailyProblem domain.DailyProblem) error {
    // Check if the daily problem exists
    existingDailyProblem, err := uc.DailyProblemRepository.GetDailyProblemByID(ctx, id)
    if err != nil {
        return errors.New("daily problem not found")
    }

    // Perform validation
    if dailyProblem.ProblemID != 0 {
        existingDailyProblem.ProblemID = dailyProblem.ProblemID
    }
    if dailyProblem.SuperGroupID != 0 {
        existingDailyProblem.SuperGroupID = dailyProblem.SuperGroupID
    }
    if !dailyProblem.ForDate.IsZero() {
        existingDailyProblem.ForDate = dailyProblem.ForDate
    }

    // Call the repository to update the daily problem
    return uc.DailyProblemRepository.UpdateDailyProblem(ctx, existingDailyProblem)
}

// DeleteDailyProblem deletes a daily problem by its ID.
func (uc DailyProblemUseCase) DeleteDailyProblem(ctx context.Context, id int) error {
    // Check if the daily problem exists
    if _, err := uc.DailyProblemRepository.GetDailyProblemByID(ctx, id); err != nil {
        return errors.New("daily problem not found")
    }

    // Call the repository to delete the daily problem
    return uc.DailyProblemRepository.DeleteDailyProblem(ctx, id)
}

// NewDailyProblemUseCase creates a new instance of DailyProblemUseCase.
func NewDailyProblemUseCase(dailyProblemRepository domain.DailyProblemRepository) domain.DailyProblemUseCase {
    return DailyProblemUseCase{
        DailyProblemRepository: dailyProblemRepository,
    }
}