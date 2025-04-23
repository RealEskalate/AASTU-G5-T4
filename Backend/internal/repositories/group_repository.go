package repositories

import (
	"A2SVHUB/internal/domain"

	"context"

	"gorm.io/gorm"
)

type GroupRepository struct {
	DB      *gorm.DB
	context context.Context
}

func NewGroupRepository(db *gorm.DB) *GroupRepository {
	return &GroupRepository{
		DB: db,
	}
}

func (r *GroupRepository) CreateGroup(group domain.Group) error {
	return r.DB.WithContext(r.context).Create(&group).Error
}

func (r *GroupRepository) GetGroupByID(id int) (domain.Group, error) {
	var group domain.Group
	if err := r.DB.WithContext(r.context).First(&group, id).Error; err != nil {
		return domain.Group{}, err
	}
	return group, nil
}

func (r *GroupRepository) GetAllGroups() ([]domain.Group, error) {
	var groups []domain.Group
	if err := r.DB.WithContext(r.context).Find(&groups).Error; err != nil {
		return nil, err
	}
	return groups, nil
}

func (r *GroupRepository) UpdateGroupByID(group domain.Group) error {
	return r.DB.WithContext(r.context).Save(&group).Error
}

func (r *GroupRepository) DeleteGroupByID(id int) error {
	return r.DB.WithContext(r.context).Delete(&domain.Group{}, id).Error
}
