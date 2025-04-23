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

type ProblemTrack struct {
	ID        int       `gorm:"primaryKey"`
	ProblemID int       `gorm:"type:integer"`
	TrackID   int       `gorm:"type:integer"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Problem   Problem   `gorm:"foreignKey:ProblemID"`
	Track     Track     `gorm:"foreignKey:TrackID"`
}

type Exercise struct {
	ID        int       `gorm:"primaryKey"`
	TrackID   int       `gorm:"type:integer"`
	ProblemID int       `gorm:"type:integer"`
	GroupID   int       `gorm:"type:integer"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Track     Track     `gorm:"foreignKey:TrackID"`
	Problem   Problem   `gorm:"foreignKey:ProblemID"`
	Group     Group     `gorm:"foreignKey:GroupID"`
}
