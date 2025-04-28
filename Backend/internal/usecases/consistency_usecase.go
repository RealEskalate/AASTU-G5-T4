package usecases

import (
	"A2SVHUB/internal/domain"
	"time"
)

type ConsistencyUseCase struct {
	repository domain.OutsideConsistencyRepository
}

// GetConsistencyOfGroup implements domain.OutsideConsistencyUseCase.
func (c *ConsistencyUseCase) GetConsistencyOfGroup(id int, startDate time.Time, endDate time.Time) []domain.OutsideConsistency {
	if id <= 0 {
		panic("Invalid group ID")
	}
	if endDate.Before(startDate) {
		panic("End date cannot be before start date")
	}
	return c.repository.GetConsistencyOfGroup(id, startDate, endDate)
}

// GetConsistencyOfUser implements domain.OutsideConsistencyUseCase.
func (c *ConsistencyUseCase) GetConsistencyOfUser(id int, startDate time.Time, endDate time.Time) domain.OutsideConsistency {
	if id <= 0 {
		panic("Invalid user ID")
	}
	if endDate.Before(startDate) {
		panic("End date cannot be before start date")
	}
	return c.repository.GetConsistencyOfUser(id, startDate, endDate)
}

func NewConsistencyUseCase(repository domain.OutsideConsistencyRepository) domain.OutsideConsistencyUseCase {
	return &ConsistencyUseCase{
		repository: repository,
	}
}
