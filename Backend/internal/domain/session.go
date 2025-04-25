package domain

// models/session.go

import (
	"A2SVHUB/internal/dtos"
	"time"
)

type Session struct {
	ID              int       `gorm:"primaryKey"`
	Name            string    `gorm:"type:varchar(255)"`
	Description     string    `gorm:"type:text"`
	StartTime       time.Time `gorm:"type:timestamp"`
	EndTime         time.Time `gorm:"type:timestamp"`
	MeetLink        string    `gorm:"type:varchar(255)"`
	Location        string    `gorm:"type:varchar(255)"`
	ResourceLink    string    `gorm:"type:varchar(255)"`
	RecordingLink   string    `gorm:"type:varchar(255)"`
	CalendarEventID string    `gorm:"type:varchar(255)"`
	LecturerID      int       `gorm:"type:integer"`
	FundID          int       `gorm:"type:integer"`
	CreatedAt       time.Time `gorm:"type:timestamp"`
	UpdatedAt       time.Time `gorm:"type:timestamp"`
	Lecturer        User      `gorm:"foreignKey:LecturerID"`
	Fund            Fund      `gorm:"foreignKey:FundID"`
}

type Attendance struct {
	ID        int       `gorm:"primaryKey"`
	UserID    int       `gorm:"type:integer"`
	HeadID    int       `gorm:"type:integer"`
	Status    int       `gorm:"type:integer"`
	At        time.Time `gorm:"type:timestamp"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	SessionID int       `gorm:"type:integer"`
	Type      int       `gorm:"type:integer"`
	User      User      `gorm:"foreignKey:UserID"`
	Head      User      `gorm:"foreignKey:HeadID"`
	Session   Session   `gorm:"foreignKey:SessionID"`
}

type Stipend struct {
	ID        int       `gorm:"primaryKey"`
	FundID    int       `gorm:"type:integer"`
	UserID    int       `gorm:"type:integer"`
	Paid      bool      `gorm:"default:false"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	SessionID int       `gorm:"type:integer"`
	Share     float32   `gorm:"type:real"`
	Fund      Fund      `gorm:"foreignKey:FundID"`
	User      User      `gorm:"foreignKey:UserID"`
	Session   Session   `gorm:"foreignKey:SessionID"`
}


// session usecase

type SessionUseCase interface {
	GetAllSessions(filters map[string]interface{}) ([]dtos.SessionDTOS, *ErrorResponse)
	GetSessionByID(id string) (*dtos.SessionDTOS, *ErrorResponse)
	CreateSession(session dtos.CreateSessionDTOS) (*dtos.SessionDTOS, *ErrorResponse)
	UpdateSession(id string, session dtos.UpdateSessionDTOS) (*dtos.SessionDTOS, *ErrorResponse)
	DeleteSession(id string) *ErrorResponse
}

type SessionRepository interface {
	GetAllSessions(filters map[string]interface{}) ([]Session, error)
	GetSessionByID(id string) (*Session, error)
	GetSessionByName(name string) (*Session, error)
	GetSessionByLecturerId(id int) (*Session, error)
	GetSessionByLocation(location string) (*Session, error)
	CreateSession(session dtos.CreateSessionDTOS) (Session, error)
	UpdateSession(session *Session) error
	DeleteSession(session *Session) error
}