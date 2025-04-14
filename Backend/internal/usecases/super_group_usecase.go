package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
	"errors"
)

type SuperGroupUseCase struct {
	SuperGroupRepository domain.SuperGroupRepository
}

// CreateSuperGroup implements domain.SuperGroupUseCase.
func (s SuperGroupUseCase) CreateSuperGroup(ctx context.Context, name string) (domain.SuperGroup, error) {
	return s.SuperGroupRepository.CreateSuperGroup(ctx, name)
}

// DeleteSuperGroup implements domain.SuperGroupUseCase.
func (s SuperGroupUseCase) DeleteSuperGroup(ctx context.Context, ID int) error {
	superGroup, err := s.SuperGroupRepository.FindSuperGroupByID(ctx, ID)
	if err != nil {
		return err
	}
	if superGroup.ID == 0 {
		return errors.New("super group not found")
	}
	return s.SuperGroupRepository.DeleteSuperGroup(ctx, ID)
}

// FindSuperGroupByID implements domain.SuperGroupUseCase.
func (s SuperGroupUseCase) FindSuperGroupByID(ctx context.Context, ID int) (domain.SuperGroup, error) {
	return s.SuperGroupRepository.FindSuperGroupByID(ctx, ID)
}

// FindSuperGroupByName implements domain.SuperGroupUseCase.
func (s SuperGroupUseCase) FindSuperGroupByName(ctx context.Context, name string) ([]domain.SuperGroup, error) {
	return s.SuperGroupRepository.FindSuperGroupByName(ctx, name)
}

// GetAllSuperGroups implements domain.SuperGroupUseCase.
func (s SuperGroupUseCase) GetAllSuperGroups(ctx context.Context) ([]domain.SuperGroup, error) {
	return s.SuperGroupRepository.GetAllSuperGroups(ctx)
}

// UpdateSuperGroup implements domain.SuperGroupUseCase.
func (s SuperGroupUseCase) UpdateSuperGroup(ctx context.Context, name string, ID int) (domain.SuperGroup, error) {
	superGroup, err := s.SuperGroupRepository.FindSuperGroupByID(ctx, ID)
	if err != nil {
		return domain.SuperGroup{}, err
	}
	if superGroup.ID == 0 {
		return domain.SuperGroup{}, errors.New("super group not found")
	}
	return s.SuperGroupRepository.UpdateSuperGroup(ctx, name, ID)
}

func NewSuperGroupUseCase(SuperGroupRepository domain.SuperGroupRepository) domain.SuperGroupUseCase {
	return SuperGroupUseCase{
		SuperGroupRepository: SuperGroupRepository,
	}
}
