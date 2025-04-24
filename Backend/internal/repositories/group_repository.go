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
func (r *GroupRepository) CreateGroup(group *domain.Group) error {
	if err := r.DB.WithContext(r.context).Create(group).Error; err != nil {
		return err
	}

	// Reload with preload
	if err := r.DB.WithContext(r.context).Preload("Country").First(group, group.ID).Error; err != nil {
		return err
	}
	return nil
}

func (r *GroupRepository) GetGroupByID(id int) (domain.Group, error) {
	var group domain.Group
	if err := r.DB.WithContext(r.context).Preload("Country").First(&group, id).Error; err != nil {
		return domain.Group{}, err
	}
	return group, nil
}

//	func (r *GroupRepository) GetAllGroups() ([]domain.Group, error) {
//		var groups []domain.Group
//		if err := r.DB.WithContext(r.context).Find(&groups).Error; err != nil {
//			return nil, err
//		}
//		return groups, nil
//	}
func (r *GroupRepository) GetAllGroups() ([]domain.Group, error) {
	var groups []domain.Group
	if err := r.DB.WithContext(r.context).Preload("Country").Find(&groups).Error; err != nil {
		return nil, err
	}
	return groups, nil
}

func (r *GroupRepository) UpdateGroupByID(group *domain.Group) error {
	if err := r.DB.WithContext(r.context).Preload("Country").First(group, group.ID).Error; err != nil {
		return err
	}
	return r.DB.WithContext(r.context).Save(&group).Error
}

func (r *GroupRepository) DeleteGroupByID(id int) error {
	return r.DB.WithContext(r.context).Delete(&domain.Group{}, id).Error
}

func (r *GroupRepository) FindByUniqueFields(ctx context.Context, name, shortName, description string, group *domain.Group) error {
	return r.DB.WithContext(ctx).Where("name = ? AND short_name = ? AND description = ?", name, shortName, description).First(group).Error
}
