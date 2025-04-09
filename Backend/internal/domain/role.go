package domain

import "time"

type Role struct {
	ID        int       `gorm:"primaryKey"`
	Type      string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}


type RoleRepositoryInterface interface {
	GetAllRoles() ([]Role, error)
	GetRoleByID(id string) (*Role, error)
	CreateRole(role *Role) error
	UpdateRole(role *Role) error
	DeleteRole(role *Role) error
}

type RoleUseCaseInterface interface {
	GetAllRoles() ([]Role, error)
	GetRoleByID(id string) (*Role, error)
	CreateRole(role *Role) error
	UpdateRole(role *Role) error
	DeleteRole(id string) error
}