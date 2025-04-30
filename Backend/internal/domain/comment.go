package domain

// models/comment.go

import "time"

type Comment struct {
	ID           int        `gorm:"primaryKey"`
	UserID       int        `gorm:"type:integer"`
	PostID       int        `gorm:"type:integer"`
	SubmissionID int        `gorm:"type:integer"`
	ProblemID    int        `gorm:"type:integer"`
	TrackID      int        `gorm:"type:integer"`
	ReplyID      int        `gorm:"type:integer"`
	Text         string     `gorm:"type:text"`
	CreatedAt    time.Time  `gorm:"type:timestamp"`
	UpdatedAt    time.Time  `gorm:"type:timestamp"`
	User         User       `gorm:"foreignKey:UserID"`
	Post         Post       `gorm:"foreignKey:PostID"`
	Submission   Submission `gorm:"foreignKey:SubmissionID"`
	Problem      Problem    `gorm:"foreignKey:ProblemID"`
	Track        Track      `gorm:"foreignKey:TrackID"`
	Reply        *Comment   `gorm:"foreignKey:ReplyID"`
}

type Vote struct {
	ID           int        `gorm:"primaryKey"`
	UserID       int        `gorm:"type:integer"`
	CommentID    int        `gorm:"type:integer"`
	PostID       int        `gorm:"type:integer"`
	ProblemID    int        `gorm:"type:integer"`
	TrackID      int        `gorm:"type:integer"`
	ContestID    int        `gorm:"type:integer"`
	SubmissionID int        `gorm:"type:integer"`
	Type         int        `gorm:"type:integer"`
	CreatedAt    time.Time  `gorm:"type:timestamp"`
	UpdatedAt    time.Time  `gorm:"type:timestamp"`
	User         User       `gorm:"foreignKey:UserID"`
	Comment      Comment    `gorm:"foreignKey:CommentID"`
	Post         Post       `gorm:"foreignKey:PostID"`
	Problem      Problem    `gorm:"foreignKey:ProblemID"`
	Track        Track      `gorm:"foreignKey:TrackID"`
	Contest      Contest    `gorm:"foreignKey:ContestID"`
	Submission   Submission `gorm:"foreignKey:SubmissionID"`
}
