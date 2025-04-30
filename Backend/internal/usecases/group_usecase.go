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

func (uc *groupUseCase) CreateGroup(ctx context.Context, name, shortName, desc string, hoaid *int, countryID int) (domain.Group, error) {
	group := domain.Group{
		Name:        name,
		ShortName:   shortName,
		Description: desc,
		HOAID:       hoaid,
		CountryID:   countryID,
	}
	if err := uc.groupRepo.CreateGroup(&group); err != nil {
		return domain.Group{}, err
	}
	return group, nil
}

func (uc *groupUseCase) UpdateGroupByID(ctx context.Context, name, shortName, description string, hoaID *int, countryID, id int) (domain.Group, error) {
	group := domain.Group{
		ID:          id,
		Name:        name,
		ShortName:   shortName,
		Description: description,
		HOAID:       hoaID,
		CountryID:   countryID,
	}
	if err := uc.groupRepo.UpdateGroupByID(&group); err != nil {
		return domain.Group{}, err
	}
	return group, nil
}

func (uc *groupUseCase) DeleteGroupByID(ctx context.Context, id int) error {
	return uc.groupRepo.DeleteGroupByID(id)
}

func (uc *groupUseCase) GetGroupByUniqueFields(ctx context.Context, name, shortName, description string) (domain.Group, error) {
	var group domain.Group
	err := uc.groupRepo.FindByUniqueFields(ctx, name, shortName, description, &group)
	return group, err
}
