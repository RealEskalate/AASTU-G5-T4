package repositories

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"

	"context"

	"gorm.io/gorm"
)

type SessionRepository struct {
	DB *gorm.DB
	context context.Context
}

func NewSessionRepository(db *gorm.DB, context context.Context) *SessionRepository {
	return &SessionRepository{
		DB: db,
		context: context,
	}
}

func (r *SessionRepository) GetAllSessions() ([]domain.Session, error) {
	var sessions []domain.Session
	if err := r.DB.WithContext(r.context).Find(&sessions).Error; err != nil {
		return nil, err
	}
	return sessions, nil
}

func (r *SessionRepository) GetSessionByID(id string) (*domain.Session, error) {
	var session domain.Session
	if err := r.DB.WithContext(r.context).First(&session, id).Error; err != nil {
		return nil, err
	}
	return &session, nil
}

func (r *SessionRepository) GetSessionByName(name string) (*domain.Session, error) {
	var session domain.Session
	if err := r.DB.WithContext(r.context).Where("name = ?", name).First(&session).Error; err != nil {
		return nil, err
	}
	return &session, nil
}

func (r *SessionRepository) GetSessionByLecturerId(id int) (*domain.Session, error) {
	var session domain.Session
	if err := r.DB.WithContext(r.context).Where("lecturer_id = ?", id).First(&session).Error; err != nil {
		return nil, err
	}
	return &session, nil
}

func (r *SessionRepository) GetSessionByLocation(location string) (*domain.Session, error) {
	var session domain.Session
	if err := r.DB.WithContext(r.context).Where("location = ?", location).First(&session).Error; err != nil {
		return nil, err
	}
	return &session, nil
}

func (r *SessionRepository) CreateSession(session dtos.CreateSessionDTOS) (domain.Session, error ){
	var newSession  = domain.Session{
		Name: session.Name,
		Description: session.Description,
		StartTime: session.StartTime,
		EndTime: session.EndTime,
		MeetLink: session.MeetLink,
		Location: session.Location,
		ResourceLink: session.ResourceLink,
		RecordingLink: session.RecordingLink,
		CalendarEventID: session.CalendarEventID,
		LecturerID: session.LecturerID,
		FundID: session.FundID,
	}
	if err := r.DB.WithContext(r.context).Create(&newSession).Error; err != nil {
		return domain.Session{}, err
	}
	return newSession, nil
}


func (r *SessionRepository) UpdateSession(session *domain.Session) error {
	if err := r.DB.WithContext(r.context).Save(session).Error; err != nil {
		return err
	}
	return nil
}

func (r *SessionRepository) DeleteSession(session *domain.Session) error {
	if err := r.DB.WithContext(r.context).Delete(&session).Error; err != nil {
		return err
	}
	return nil
}