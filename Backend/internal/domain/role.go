package domain

import "time"

type Role struct {
	ID        int       `gorm:"primaryKey"`
	Type      string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}


type RoleRepository interface {
	GetAllRoles() ([]Role, error)
	GetRoleByID(id string) (*Role, error)
	CreateRole(role Role) (Role, error)
	UpdateRole(role *Role) error
	DeleteRole(role *Role) error
	GetRoleByType(roleType string) (*Role, error)
}

type RoleUseCase interface {
	GetAllRoles() ([]Role, error)
	GetRoleByID(id string) (*Role, error)
	CreateRole(roleType string) (Role, error)
	UpdateRole(roleType string, id string) (Role, error)
	DeleteRole(id string) error
}