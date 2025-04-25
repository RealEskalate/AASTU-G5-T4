package dtos

import "time"

type SessionDTOS struct {
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
}


type CreateSessionDTOS struct {
	Name            string    `json:"name" binding:"required"`
	Description     string    `json:"description" binding:"required"`
	StartTime       time.Time `json:"start_time" binding:"required"`
	EndTime         time.Time `json:"end_time" binding:"required"`
	MeetLink        string    `json:"meet_link"`
	Location        string    `json:"location"`
	ResourceLink    string    `json:"resource_link"`
	RecordingLink   string    `json:"recording_link"`
	CalendarEventID string    `json:"calendar_event_id"`
	LecturerID      int       `json:"lecturer_id" binding:"required"`
	FundID          int       `json:"fund_id" binding:"required"`
}


type UpdateSessionDTOS struct {
	Name            string    `json:"name" binding:"required"`
	Description     string    `json:"description" binding:"required"`
	StartTime       time.Time `json:"start_time" binding:"required"`
	EndTime         time.Time `json:"end_time" binding:"required"`
	MeetLink        string    `json:"meet_link"`
	Location        string    `json:"location"`
	ResourceLink    string    `json:"resource_link"`
	RecordingLink   string    `json:"recording_link"`
	CalendarEventID string    `json:"calendar_event_id"`
	LecturerID      int       `json:"lecturer_id"`
	FundID          int       `json:"fund_id"`
}