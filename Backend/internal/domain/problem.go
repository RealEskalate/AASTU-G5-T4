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

type Problem struct {
	ID         int       `gorm:"primaryKey"`
	ContestID  *int      `gorm:"type:integer"`
	TrackID    *int      `gorm:"type:integer"`
	Name       string    `gorm:"type:varchar(255)"`
	Difficulty string    `gorm:"type:varchar(255)"`
	Tag        string    `gorm:"type:varchar(255)"`
	Platform   string    `gorm:"type:varchar(255)"`
	Link       string    `gorm:"type:varchar(255)"`
	CreatedAt  time.Time `gorm:"type:timestamp"`
	UpdatedAt  time.Time `gorm:"type:timestamp"`
	Contest    *Contest  `gorm:"foreignKey:ContestID"`
	Track      *Track    `gorm:"foreignKey:TrackID"`
}

type ProblemRepository interface {
	CreateProblem(ctx context.Context, problem Problem) (Problem, error)
	GetProblemByID(ctx context.Context, id int) (Problem, error)
	GetProblemByName(ctx context.Context, name string) ([]Problem, error)
	UpdateProblem(ctx context.Context, problem Problem) error
	DeleteProblem(ctx context.Context, id int) error
	GetProblemsByNameAndFilters(ctx context.Context, name string, filter map[string]interface{}) ([]Problem, error)
}

type ProblemUseCase interface {
	CreateProblem(ctx context.Context, problem Problem) (Problem, error)
	GetProblemByID(ctx context.Context, id int) (Problem, error)
	GetProblemByName(ctx context.Context, name string) ([]Problem, error)
	UpdateProblem(ctx context.Context, id int, problem Problem) error
	DeleteProblem(ctx context.Context, id int) error
	GetProblemsByNameAndFilters(ctx context.Context, name string, filter map[string]interface{}) ([]Problem, error)
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
