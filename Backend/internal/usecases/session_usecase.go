package usecases

import (
	domain "A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	utils "A2SVHUB/pkg/utils"
	"time"
)

type SessionUseCase struct {
	SessionRepository domain.SessionRepository
}

func NewSessionUseCase(SessionRepository domain.SessionRepository) *SessionUseCase {
	return &SessionUseCase{
		SessionRepository: SessionRepository,
	}
}

func (r *SessionUseCase) GetAllSessions(filters map[string]interface{}) ([]dtos.SessionDTOS, *domain.ErrorResponse) {
	sessions, err := r.SessionRepository.GetAllSessions(filters)

	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to retrieve sessions",
			Status:  500,
		}
	}

	if len(sessions) == 0 {
		return nil, &domain.ErrorResponse{
			Message: "No sessions found",
			Status:  404,
		}
	}


	var sessionDTOs []dtos.SessionDTOS
	for _, session := range sessions {
		sessionDTOs = append(sessionDTOs, dtos.SessionDTOS{
			ID:              session.ID,
			Name:            session.Name,
			Description:     session.Description,
			StartTime:       session.StartTime,
			EndTime:         session.EndTime,
			MeetLink:        session.MeetLink,
			Location:        session.Location,
			ResourceLink:    session.ResourceLink,
			RecordingLink:   session.RecordingLink,
			CalendarEventID: session.CalendarEventID,
			LecturerID:      session.LecturerID,
			FundID:          session.FundID,
			CreatedAt:       session.CreatedAt,
			UpdatedAt:       session.UpdatedAt,
		})
	}
	return sessionDTOs, nil
}

func (r *SessionUseCase) GetSessionByID(id string) (*dtos.SessionDTOS, *domain.ErrorResponse) {
	session, err := r.SessionRepository.GetSessionByID(id)
	if err != nil && err.Error() == "record not found" {
		return nil, &domain.ErrorResponse{
			Message: "Session not found",
			Status:  404,
		}
	}

	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to retrieve session",
			Status:  500,
		}
	}

	
	return &dtos.SessionDTOS{
		ID:              session.ID,
		Name:            session.Name,
		Description:     session.Description,
		StartTime:       session.StartTime,
		EndTime:         session.EndTime,
		MeetLink:        session.MeetLink,
		Location:        session.Location,
		ResourceLink:    session.ResourceLink,
		RecordingLink:   session.RecordingLink,
		CalendarEventID: session.CalendarEventID,
		LecturerID:      session.LecturerID,
		FundID:          session.FundID,
		CreatedAt:       session.CreatedAt,
		UpdatedAt:       session.UpdatedAt,
	}, nil
}

func (r *SessionUseCase) CreateSession(session dtos.CreateSessionDTOS) (*dtos.SessionDTOS, *domain.ErrorResponse) {
	if session.StartTime.Before(time.Now()) || session.EndTime.Before(time.Now()) {
		return &dtos.SessionDTOS{}, &domain.ErrorResponse{
			Message: "Start time and end time must be after current time",
			Status:  400,
		}
	}
	if session.StartTime.After(session.EndTime) {
		return &dtos.SessionDTOS{}, &domain.ErrorResponse{
			Message: "Start time must be before end time",
			Status:  400,
		}
	}
	existingSession, err := r.SessionRepository.GetSessionByName(session.Name)
	if err == nil && existingSession != nil {
		return &dtos.SessionDTOS{}, &domain.ErrorResponse{
			Message: "Session with the same name already exists",
			Status:  400,
		}
	}

	existingSessionByLecturer, err := r.SessionRepository.GetSessionByLecturerId(session.LecturerID)
	if err == nil && existingSessionByLecturer != nil {
		if session.StartTime.Equal(existingSessionByLecturer.StartTime) && session.EndTime.Equal(existingSessionByLecturer.EndTime) {
			return &dtos.SessionDTOS{}, &domain.ErrorResponse{
				Message: "Session with the same lecturer and time already exists",
				Status:  400,
			}
		}
	}

	existingSessionByLocation, err := r.SessionRepository.GetSessionByLocation(session.Location)
	if err == nil && existingSessionByLocation != nil {
		if session.StartTime.Equal(existingSessionByLocation.StartTime) && session.EndTime.Equal(existingSessionByLocation.EndTime) {
			return &dtos.SessionDTOS{}, &domain.ErrorResponse{
				Message: "Session with the same location and time already exists",
				Status:  400,
			}
		}
	}
	newSession, err := r.SessionRepository.CreateSession(session)
	if err != nil {
		return &dtos.SessionDTOS{}, &domain.ErrorResponse{
			Message: "Failed to create session",
			Status:  500,
		}
	}
	return &dtos.SessionDTOS{
		ID:              newSession.ID,
		Name:            newSession.Name,
		Description:     newSession.Description,
		StartTime:       newSession.StartTime,
		EndTime:         newSession.EndTime,
		MeetLink:        newSession.MeetLink,
		Location:        newSession.Location,
		ResourceLink:    newSession.ResourceLink,
		RecordingLink:   newSession.RecordingLink,
		CalendarEventID: newSession.CalendarEventID,
		LecturerID:      newSession.LecturerID,
		FundID:          newSession.FundID,
		CreatedAt:       newSession.CreatedAt,
		UpdatedAt:       newSession.UpdatedAt,
	}, nil
}

func (r *SessionUseCase) UpdateSession(id string, session dtos.UpdateSessionDTOS) (*dtos.SessionDTOS, *domain.ErrorResponse) {
	existingSession, err := r.SessionRepository.GetSessionByID(id)
	if err != nil && err.Error() == "record not found" {
		return nil, &domain.ErrorResponse{
			Message: "Session not found",
			Status:  404,
		}
	}

	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to retrieve session",
			Status:  500,
		}
	}

	existingSessionByLecturer, err := r.SessionRepository.GetSessionByLecturerId(session.LecturerID)
	if err == nil && existingSessionByLecturer != nil {
		if session.StartTime.Equal(existingSessionByLecturer.StartTime) && session.EndTime.Equal(existingSessionByLecturer.EndTime) {
			return &dtos.SessionDTOS{}, &domain.ErrorResponse{
				Message: "Session with the same lecturer and time already exists",
				Status:  400,
			}
		}
	}

	existingSessionByLocation, err := r.SessionRepository.GetSessionByLocation(session.Location)
	if err == nil && existingSessionByLocation != nil {
		if session.StartTime.Equal(existingSessionByLocation.StartTime) && session.EndTime.Equal(existingSessionByLocation.EndTime) {
			return &dtos.SessionDTOS{}, &domain.ErrorResponse{
				Message: "Session with the same location and time already exists",
				Status:  400,
			}
		}
	}

	updatedSession := utils.UpdateSessionUtil(&session, existingSession)

	if err := r.SessionRepository.UpdateSession(updatedSession); err != nil {
		return &dtos.SessionDTOS{}, &domain.ErrorResponse{
			Message: "Failed to update session",
			Status: 500,
		}
	}
	return &dtos.SessionDTOS{
		ID:              updatedSession.ID,
		Name:            updatedSession.Name,
		Description:     updatedSession.Description,
		StartTime:       updatedSession.StartTime,
		EndTime:         updatedSession.EndTime,
		MeetLink:        updatedSession.MeetLink,
		Location:        updatedSession.Location,
		ResourceLink:    updatedSession.ResourceLink,
		RecordingLink:   updatedSession.RecordingLink,
		CalendarEventID: updatedSession.CalendarEventID,
		LecturerID:      updatedSession.LecturerID,
		FundID:          updatedSession.FundID,
		CreatedAt:       updatedSession.CreatedAt,
		UpdatedAt:       updatedSession.UpdatedAt,

	}, nil
}

func (r *SessionUseCase) DeleteSession(id string) *domain.ErrorResponse {
	session, err := r.SessionRepository.GetSessionByID(id)
	if err != nil {
		return &domain.ErrorResponse{
			Message: "Failed to retrieve session",
			Status:  500,
		}
	}

	if session == nil {
		return &domain.ErrorResponse{
			Message: "Session not found",
			Status:  404,
		}
	}
	if err := r.SessionRepository.DeleteSession(session); err != nil {
		return &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}
	return nil
}

func (r *SessionUseCase) GetSessionByLecturer(lecturer_id int) (*dtos.SessionDTOS, *domain.ErrorResponse) {
	session, err := r.SessionRepository.GetSessionByLecturerId(lecturer_id)
	if err != nil && err.Error() == "record not found" {
		return nil, &domain.ErrorResponse{
			Message: "No session found",
			Status:  404,
		}
	}

	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to retrieve session",
			Status:  500,
		}
	}
	return &dtos.SessionDTOS{
		ID:              session.ID,
		Name:            session.Name,
		Description:     session.Description,
		StartTime:       session.StartTime,
		EndTime:         session.EndTime,
		MeetLink:        session.MeetLink,
		Location:        session.Location,
		ResourceLink:    session.ResourceLink,
		RecordingLink:   session.RecordingLink,
		CalendarEventID: session.CalendarEventID,
		LecturerID:      session.LecturerID,
		FundID:          session.FundID,
		CreatedAt:       session.CreatedAt,
		UpdatedAt:       session.UpdatedAt,
	}, nil
}
