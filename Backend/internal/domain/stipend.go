package domain

import (
	"time"
)

type Stipend struct {
	ID        int       `gorm:"primaryKey" json:"id"`
	FundID    int       `gorm:"type:integer" json:"fund_id"`
	UserID    int       `gorm:"type:integer" json:"user_id"`
	Paid      bool      `gorm:"default:false" json:"paid"`
	CreatedAt time.Time `gorm:"type:timestamp" json:"created_at"`
	UpdatedAt time.Time `gorm:"type:timestamp" json:"updated_at"`
	SessionID int       `gorm:"type:integer" json:"session_id"`
	Share     float32   `gorm:"type:real" json:"share"`
	Fund      Fund      `gorm:"foreignKey:FundID" json:"fund,omitempty"`
	User      User      `gorm:"foreignKey:UserID" json:"user,omitempty"`
	Session   Session   `gorm:"foreignKey:SessionID" json:"session,omitempty"`
}
