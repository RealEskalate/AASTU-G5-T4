package domain

import (
	"context"
	"time"
)

type SuperGroup struct {
	ID        int       `gorm:"primaryKey"`
	Name      string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}

type SuperToGroup struct {
	ID           int        `gorm:"primaryKey"`
	GroupID      int        `gorm:"type:integer"`
	SuperGroupID int        `gorm:"type:integer"`
	CreatedAt    time.Time  `gorm:"type:timestamp"`
	UpdatedAt    time.Time  `gorm:"type:timestamp"`
	Group        Group      `gorm:"foreignKey:GroupID"`
	SuperGroup   SuperGroup `gorm:"foreignKey:SuperGroupID"`
}

type SuperGroupRepository interface {
	GetAllSuperGroups(ctx context.Context) ([]SuperGroup, error)
	CreateSuperGroup(ctx context.Context, name string) (SuperGroup, error)
	UpdateSuperGroup(ctx context.Context, name string, ID int) (SuperGroup, error)
	DeleteSuperGroup(ctx context.Context, ID int) error
	FindSuperGroupByName(ctx context.Context, name string) ([]SuperGroup, error)
	FindSuperGroupByID(ctx context.Context, ID int) (SuperGroup, error)
}

type SuperGroupUseCase interface {
	GetAllSuperGroups(ctx context.Context) ([]SuperGroup, error)
	CreateSuperGroup(ctx context.Context, name string) (SuperGroup, error)
	UpdateSuperGroup(ctx context.Context, name string, ID int) (SuperGroup, error)
	DeleteSuperGroup(ctx context.Context, ID int) error
	FindSuperGroupByName(ctx context.Context, name string) ([]SuperGroup, error)
	FindSuperGroupByID(ctx context.Context, ID int) (SuperGroup, error)
}
