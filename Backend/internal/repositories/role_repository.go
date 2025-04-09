package repositories

import (
	"A2SVHUB/internal/domain"

	"gorm.io/gorm"
)

type RoleRepository struct {
	DB *gorm.DB
}

func NewRoleRepository(db *gorm.DB) *RoleRepository {
	return &RoleRepository{
		DB: db,
	}
}

func (r *RoleRepository) GetAllRoles() ([]domain.Role, error) {
	var roles []domain.Role
	if err := r.DB.Find(&roles).Error; err != nil {
		return nil, err
	}
	return roles, nil
}

func (r *RoleRepository) GetRoleByID(id string) (*domain.Role, error) {
	var role domain.Role
	if err := r.DB.First(&role, id).Error; err != nil {
		return nil, err
	}
	return &role, nil
}

func (r *RoleRepository) CreateRole(role *domain.Role) error {
	if err := r.DB.Create(role).Error; err != nil {
		return err
	}
	return nil
}


func (r *RoleRepository) UpdateRole(role *domain.Role) error {
	if err := r.DB.Save(role).Error; err != nil {
		return err
	}
	return nil
}

func (r *RoleRepository) DeleteRole(role *domain.Role) error {
	if err := r.DB.Delete(&role).Error; err != nil {
		return err
	}
	return nil
}

