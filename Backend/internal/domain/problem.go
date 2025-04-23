package domain

// models/problem.go

import (
	"context"
	"time"
)

type DailyProblem struct {
	ID           int        `gorm:"primaryKey"`
	ProblemID    int        `gorm:"type:integer"`
	SuperGroupID int        `gorm:"type:integer"`
	ForDate      time.Time  `gorm:"type:date"`
	CreatedAt    time.Time  `gorm:"type:timestamp"`
	UpdatedAt    time.Time  `gorm:"type:timestamp"`
	Problem      Problem    `gorm:"foreignKey:ProblemID"`
	SuperGroup   SuperGroup `gorm:"foreignKey:SuperGroupID"`
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

type Submission struct {
	ID        int       `gorm:"primaryKey"`
	ProblemID int       `gorm:"type:integer"`
	UserID    int       `gorm:"type:integer"`
	TimeSpent int       `gorm:"type:integer"`
	Tries     int       `gorm:"type:integer"`
	InContest int       `gorm:"type:integer"`
	Code      string    `gorm:"type:text"`
	Language  string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Verified  bool      `gorm:"type:boolean"`
	Problem   Problem   `gorm:"foreignKey:ProblemID"`
	User      User      `gorm:"foreignKey:UserID"`
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

type SubmissionRepository interface {
	CreateSubmission(ctx context.Context, submission Submission) (Submission, error)
	GetSubmissionByID(ctx context.Context, id int) (Submission, error)
	GetSubmissionsByProblem(ctx context.Context, problemID int) ([]Submission, error)
	UpdateSubmission(ctx context.Context, submission Submission) (Submission, error)
	DeleteSubmission(ctx context.Context, id int) error
}
type SubmissionUseCase interface {
    CreateSubmission(ctx context.Context, submission Submission) (Submission, error)
    GetSubmissionByID(ctx context.Context, id int) (Submission, error)
    GetSubmissionsByProblem(ctx context.Context, problemID int) ([]Submission, error)
    UpdateSubmission(ctx context.Context, submission Submission) (Submission, error)
    DeleteSubmission(ctx context.Context, id int) error
}
