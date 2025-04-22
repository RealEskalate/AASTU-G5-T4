package repositories

import (
	"A2SVHUB/internal/domain"

	"context"

	"gorm.io/gorm"
)

type RoleRepository struct {
	DB *gorm.DB
	context context.Context
}

func NewRoleRepository(db *gorm.DB, context context.Context) *RoleRepository {
	return &RoleRepository{
		DB: db,
		context: context,
	}
}

func (r *RoleRepository) GetAllRoles() ([]domain.Role, error) {
	var roles []domain.Role
	if err := r.DB.WithContext(r.context).Find(&roles).Error; err != nil {
		return nil, err
	}
	return roles, nil
}

func (r *RoleRepository) GetRoleByID(id string) (*domain.Role, error) {
	var role domain.Role
	if err := r.DB.WithContext(r.context).First(&role, id).Error; err != nil {
		return nil, err
	}
	return &role, nil
}

func (r *RoleRepository) GetRoleByType(roleType string) (*domain.Role, error) {
	var role domain.Role
	if err := r.DB.WithContext(r.context).Where("type = ?", roleType).First(&role).Error; err != nil {
		return nil, err
	}
	return &role, nil
}

func (r *RoleRepository) CreateRole(role domain.Role) (domain.Role, error ){
	if err := r.DB.WithContext(r.context).Create(&role).Error; err != nil {
		return domain.Role{}, err
	}
	return role, nil
}


func (r *RoleRepository) UpdateRole(role *domain.Role) error {
	if err := r.DB.WithContext(r.context).Save(role).Error; err != nil {
		return err
	}
	return nil
}

func (r *RoleRepository) DeleteRole(role *domain.Role) error {
	if err := r.DB.WithContext(r.context).Delete(&role).Error; err != nil {
		return err
	}
	return nil
}
