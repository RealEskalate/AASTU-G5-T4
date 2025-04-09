package usecases

import (
	domain "A2SVHUB/internal/domain"
)


type RoleUseCase struct {
	roleRepository domain.RoleRepositoryInterface
}

func NewRoleUseCase(roleRepository domain.RoleRepositoryInterface) *RoleUseCase {
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


func (r *RoleUseCase) CreateRole(role *domain.Role) error {
	if err := r.roleRepository.CreateRole(role); err != nil {
		return err
	}
	return nil
}

func (r *RoleUseCase) UpdateRole(role *domain.Role) error {
	if err := r.roleRepository.UpdateRole(role); err != nil {
		return err
	}
	return nil
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
