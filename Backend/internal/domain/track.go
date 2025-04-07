package domain

// models/track.go

import "time"

type Track struct {
	ID           int        `gorm:"primaryKey"`
	Name         string     `gorm:"type:varchar(255)"`
	CreatedAt    time.Time  `gorm:"type:timestamp"`
	UpdatedAt    time.Time  `gorm:"type:timestamp"`
	Active       bool       `gorm:"default:true"`
	SuperGroupID int        `gorm:"type:integer"`
	SuperGroup   SuperGroup `gorm:"foreignKey:SuperGroupID"`
}
