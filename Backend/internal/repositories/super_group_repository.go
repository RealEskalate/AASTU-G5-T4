package repositories

import (
	"A2SVHUB/internal/domain"
	"context"
	"fmt"

	"gorm.io/gorm"
)

type SuperGroupRepository struct {
	db gorm.DB
}

// CreateSuperGroup implements domain.SuperGroupRepository.
func (s *SuperGroupRepository) CreateSuperGroup(ctx context.Context, name string) (domain.SuperGroup, error) {
	// Check if a super group with the same name already exists
	var existing domain.SuperGroup
	if err := s.db.WithContext(ctx).Where("name = ?", name).First(&existing).Error; err == nil {
		return domain.SuperGroup{}, fmt.Errorf("super group with name '%s' already exists", name)
	}

	sg := domain.SuperGroup{Name: name}
	if err := s.db.WithContext(ctx).Create(&sg).Error; err != nil {
		return domain.SuperGroup{}, err
	}
	return sg, nil
}

// DeleteSuperGroup implements domain.SuperGroupRepository.
func (s *SuperGroupRepository) DeleteSuperGroup(ctx context.Context, ID int) error {
	// Check if the super group exists
	var sg domain.SuperGroup
	if err := s.db.WithContext(ctx).First(&sg, ID).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			return fmt.Errorf("no super group found with ID %d", ID)
		}
		return err
	}

	// Delete the super group
	if err := s.db.WithContext(ctx).Delete(&sg).Error; err != nil {
		return err
	}
	return nil
}

// FindSuperGroupByID implements domain.SuperGroupRepository.
func (s *SuperGroupRepository) FindSuperGroupByID(ctx context.Context, ID int) (domain.SuperGroup, error) {
	var sg domain.SuperGroup
	if err := s.db.WithContext(ctx).First(&sg, ID).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			return domain.SuperGroup{}, fmt.Errorf("no super group found with ID %d", ID)
		}
		return domain.SuperGroup{}, err
	}
	return sg, nil
}

// FindSuperGroupByName implements domain.SuperGroupRepository.
func (s *SuperGroupRepository) FindSuperGroupByName(ctx context.Context, name string) ([]domain.SuperGroup, error) {
	var superGroups []domain.SuperGroup
	if err := s.db.WithContext(ctx).Where("name = ?", name).Find(&superGroups).Error; err != nil {
		return nil, err
	}
	if len(superGroups) == 0 {
		return nil, fmt.Errorf("no super groups found with name '%s'", name)
	}
	return superGroups, nil
}

// GetAllSuperGroups implements domain.SuperGroupRepository.
func (s *SuperGroupRepository) GetAllSuperGroups(ctx context.Context) ([]domain.SuperGroup, error) {
	var superGroups []domain.SuperGroup
	if err := s.db.WithContext(ctx).Find(&superGroups).Error; err != nil {
		return nil, err
	}
	return superGroups, nil
}

// UpdateSuperGroup implements domain.SuperGroupRepository.
func (s *SuperGroupRepository) UpdateSuperGroup(ctx context.Context, name string, ID int) (domain.SuperGroup, error) {
	// Check if the super group exists
	var sg domain.SuperGroup
	if err := s.db.WithContext(ctx).First(&sg, ID).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			return domain.SuperGroup{}, fmt.Errorf("no super group found with ID %d", ID)
		}
		return domain.SuperGroup{}, err
	}

	// Check if the new name is already taken by another super group
	var existing domain.SuperGroup
	if err := s.db.WithContext(ctx).Where("name = ?", name).First(&existing).Error; err == nil {
		return domain.SuperGroup{}, fmt.Errorf("super group with name '%s' already exists", name)
	}

	// Update the super group
	sg.Name = name
	if err := s.db.WithContext(ctx).Save(&sg).Error; err != nil {
		return domain.SuperGroup{}, err
	}
	return sg, nil
}

func NewSuperSuperGroupRepository(db gorm.DB) domain.SuperGroupRepository {
	return &SuperGroupRepository{
		db: db,
	}
}
