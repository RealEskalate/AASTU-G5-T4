package domain

import (
	"context"
	"time"
)

type Submission struct {
	ID          int       `gorm:"primaryKey"`
	UserID      int       `gorm:"type:integer"`
	ProblemID   int       `gorm:"type:integer"`
	ContestID   int       `gorm:"type:integer"`
	ContestName string    `gorm:"type:varchar(255)"`
	Status      string    `gorm:"type:varchar(255)"`
	TimeSpent   int64     `gorm:"type:bigint"`
	Code        string    `gorm:"type:text"`
	SubmittedAt time.Time `gorm:"type:timestamp"`
	Rank        int       `gorm:"type:integer"`
	Penalty     int       `gorm:"type:integer"`
	Rating      int       `gorm:"type:integer"`
	User        User      `gorm:"foreignKey:UserID"`
	Problem     Problem   `gorm:"foreignKey:ProblemID"`
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
