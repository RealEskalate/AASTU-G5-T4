package domain

// models/group.go

import "time"

type Group struct {
	ID          int       `gorm:"primaryKey"`
	Name        string    `gorm:"type:varchar(255)"`
	ShortName   string    `gorm:"type:varchar(255)"`
	Description string    `gorm:"type:varchar(255)"`
	HOAID       int       `gorm:"type:integer"`
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

type Invite struct {
	ID        int       `gorm:"primaryKey"`
	Key       string    `gorm:"type:varchar(255)"`
	RoleID    int       `gorm:"type:integer"`
	UserID    int       `gorm:"type:integer"`
	GroupID   int       `gorm:"type:integer"`
	Used      bool      `gorm:"default:false"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Role      Role      `gorm:"foreignKey:RoleID"`
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
