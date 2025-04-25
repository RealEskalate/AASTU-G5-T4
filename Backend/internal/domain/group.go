package domain

// models/group.go

import (
	"context"
	"time"
)

type Group struct {
	ID          int       `gorm:"primaryKey"`
	Name        string    `gorm:"type:varchar(255)"`
	ShortName   string    `gorm:"type:varchar(255)"`
	Description string    `gorm:"type:varchar(255)"`
	HOAID       *int      `gorm:"type:integer"`
	CountryID   int       `gorm:"type:integer"`
	CreatedAt   time.Time `gorm:"type:timestamp"`
	UpdatedAt   time.Time `gorm:"type:timestamp"`
	Country     Country   `gorm:"foreignKey:CountryID"`
}

type HOA struct {
	ID        int       `gorm:"primaryKey"`
	UserID    int       `gorm:"type:integer"`
	GroupID   int       `gorm:"type:integer"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	User      User      `gorm:"foreignKey:UserID"`
	Group     Group     `gorm:"foreignKey:GroupID"`
}

type GoogleOAuth struct {
	ID                   int       `gorm:"primaryKey"`
	UserID               int       `gorm:"type:integer"`
	GroupID              int       `gorm:"type:integer"`
	EncryptedTokenString string    `gorm:"type:text"`
	CalendarID           string    `gorm:"type:varchar(255)"`
	CreatedAt            time.Time `gorm:"type:timestamp"`
	UpdatedAt            time.Time `gorm:"type:timestamp"`
	User                 User      `gorm:"foreignKey:UserID"`
	Group                Group     `gorm:"foreignKey:GroupID"`
}

type GroupSession struct {
	ID        int       `gorm:"primaryKey"`
	GroupID   int       `gorm:"type:integer"`
	SessionID int       `gorm:"type:integer"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Group     Group     `gorm:"foreignKey:GroupID"`
	Session   Session   `gorm:"foreignKey:SessionID"`
}

type GroupUseCase interface {
	GetAllGroups(ctx context.Context) ([]Group, error)
	GetGroupByID(ctx context.Context, id int) (Group, error)
	CreateGroup(ctx context.Context, name, shortName, description string, hoaID *int, countryID int) (Group, error)
	UpdateGroupByID(ctx context.Context, name, shortName, description string, hoaID *int, countryID, id int) (Group, error)
	DeleteGroupByID(ctx context.Context, id int) error
	GetGroupByUniqueFields(ctx context.Context, name, shortName, description string) (Group, error)
}

type GroupRepository interface {
	CreateGroup(group *Group) error
	GetGroupByID(id int) (Group, error)
	GetAllGroups() ([]Group, error)
	UpdateGroupByID(group *Group) error
	DeleteGroupByID(id int) error
	FindByUniqueFields(ctx context.Context, name, shortName, description string, group *Group) error
}

