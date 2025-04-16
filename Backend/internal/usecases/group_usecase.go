package usecases

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/repositories"
)

type GroupUseCase struct {
	GroupRepo domain.GroupRepository
}

func NewGroupUseCase(repo repositories.GroupRepository) *GroupUseCase {
	return &GroupUseCase{GroupRepo: repo}
}
