package domain

// models/contest.go

import "time"

type Contest struct {
	ID           int        `gorm:"primaryKey"`
	Name         string     `gorm:"type:varchar(255)"`
	Link         string     `gorm:"type:varchar(255)"`
	ProblemCount int        `gorm:"type:integer"`
	CreatedAt    time.Time  `gorm:"type:timestamp"`
	UpdatedAt    time.Time  `gorm:"type:timestamp"`
	Unrated      bool       `gorm:"default:false"`
	SuperGroupID int        `gorm:"type:integer"`
	Type         string     `gorm:"type:varchar(255)"`
	Link2        string     `gorm:"type:varchar(255)"`
	Link3        string     `gorm:"type:varchar(255)"`
	SuperGroup   SuperGroup `gorm:"foreignKey:SuperGroupID"`
}

type Rating struct {
	ID        int       `gorm:"primaryKey"`
	ContestID int       `gorm:"type:integer"`
	UserID    int       `gorm:"type:integer"`
	Rank      int       `gorm:"type:integer"`
	Penalty   int       `gorm:"type:integer"`
	Solved    int       `gorm:"type:integer"`
	Gain      int       `gorm:"type:integer"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Points    int       `gorm:"type:integer"`
	FromPrev  int       `gorm:"default:0"`
	Contest   Contest   `gorm:"foreignKey:ContestID"`
	User      User      `gorm:"foreignKey:UserID"`
}

type DivisionUser struct {
	ID         int       `gorm:"primaryKey"`
	UserID     int       `gorm:"type:integer"`
	DivisionID int       `gorm:"type:integer"`
	ContestID  int       `gorm:"type:integer"`
	Active     bool      `gorm:"default:false"`
	CreatedAt  time.Time `gorm:"type:timestamp"`
	UpdatedAt  time.Time `gorm:"type:timestamp"`
	User       User      `gorm:"foreignKey:UserID"`
	Division   Division  `gorm:"foreignKey:DivisionID"`
	Contest    Contest   `gorm:"foreignKey:ContestID"`
}
