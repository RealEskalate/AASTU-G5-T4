package usecases

import (
	domain "A2SVHUB/internal/domain"
	"fmt"
	"time"
)


type RoleUseCase struct {
	roleRepository domain.RoleRepository
}

func NewRoleUseCase(roleRepository domain.RoleRepository) *RoleUseCase {
	return &RoleUseCase{
		roleRepository: roleRepository,
	}
}

func (r *RoleUseCase) GetAllRoles() ([]domain.Role, error) {
	roles, err := r.roleRepository.GetAllRoles()
	if err != nil {
		return nil, err
	}
	return roles, nil
}

func (r *RoleUseCase) GetRoleByID(id string) (*domain.Role, error) {
	role, err := r.roleRepository.GetRoleByID(id)
	if err != nil {
		return nil, err
	}
	return role, nil
}

func (r *RoleUseCase) CreateRole(roleType string) (domain.Role, error) {
    role, _ := r.roleRepository.GetRoleByType(roleType)
    if role != nil {
        return domain.Role{}, fmt.Errorf("role with type %s already exists", roleType)
    }
    role = &domain.Role{
        Type: roleType,
    }
    newRole, err := r.roleRepository.CreateRole(*role)
    if err != nil {
        return domain.Role{}, err
    }
    return newRole, nil
}

func (r *RoleUseCase) UpdateRole(roleType string, id string) (domain.Role, error) {
	existingRole, err := r.roleRepository.GetRoleByID(id)
	if err != nil {
		return domain.Role{}, err
	}

	if existingRole == nil {
		return domain.Role{}, err
	}

	existingType, err := r.roleRepository.GetRoleByType(roleType)
	if err == nil && existingType != nil && existingType.ID != existingRole.ID {
		return domain.Role{}, fmt.Errorf("role with type %s already exists", roleType)
	}

	existingRole.Type = roleType
	existingRole.UpdatedAt = time.Now()
	if err := r.roleRepository.UpdateRole(existingRole); err != nil {
		return domain.Role{},err
	}
	return *existingRole, nil
}

func (r *RoleUseCase) DeleteRole(id string) error {
	role, err := r.roleRepository.GetRoleByID(id)
	if err != nil {
		return err
	}
	if err := r.roleRepository.DeleteRole(role); err != nil {
		return err
	}
	return nil
}
