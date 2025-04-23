package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
	// "fmt"
)

type groupUseCase struct {
	groupRepo domain.GroupRepository
}

func NewGroupUseCase(repo domain.GroupRepository) domain.GroupUseCase {
	return &groupUseCase{
		groupRepo: repo,
	}
}

func (uc *groupUseCase) GetAllGroups(ctx context.Context) ([]domain.Group, error) {
	return uc.groupRepo.GetAllGroups()
}

func (uc *groupUseCase) GetGroupByID(ctx context.Context, id int) (domain.Group, error) {
	return uc.groupRepo.GetGroupByID(id)
}

func (uc *groupUseCase) CreateGroup(ctx context.Context, name, shortName, description string, hoaID, countryID int) (domain.Group, error) {
	group := domain.Group{
		Name:        name,
		ShortName:   shortName,
		Description: description,
		HOAID:       hoaID,
		CountryID:   countryID,
	}
	err := uc.groupRepo.CreateGroup(group)
	return group, err
}

func (uc *groupUseCase) UpdateGroupByID(ctx context.Context, name, shortName, description string, hoaID, countryID, id int) (domain.Group, error) {
	group := domain.Group{
		ID:          id,
		Name:        name,
		ShortName:   shortName,
		Description: description,
		HOAID:       hoaID,
		CountryID:   countryID,
	}
	err := uc.groupRepo.UpdateGroupByID(group)
	return group, err
}

func (uc *groupUseCase) DeleteGroupByID(ctx context.Context, id int) error {
	return uc.groupRepo.DeleteGroupByID(id)
}
