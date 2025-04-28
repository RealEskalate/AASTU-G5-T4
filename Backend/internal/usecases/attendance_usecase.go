package usecases

import (
	domain "A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"context"
	"strconv"
	"time"
)

type AttendanceUseCase struct {
	attendanceRepository domain.AttendanceRepository
	sessionRepository  domain.SessionRepository
	userRepository    domain.UserRepository
	context context.Context
}

func NewAttendanceUseCase(AttendanceRepository domain.AttendanceRepository, sessionRepository domain.SessionRepository, userRepository domain.UserRepository, context context.Context) *AttendanceUseCase {
	return &AttendanceUseCase{
		attendanceRepository: AttendanceRepository,
		sessionRepository:  sessionRepository,
		userRepository:    userRepository,
		context: context,
	}
}

func (r *AttendanceUseCase) GetAllAttendances(filters map[string]interface{}) ([]dtos.AttendanceDTOS, *domain.ErrorResponse) {
	attendances, err := r.attendanceRepository.GetAllAttendances(filters)

	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to retrieve Attendances",
			Status:  500,
		}
	}

	if len(attendances) == 0 {
		return nil, &domain.ErrorResponse{
			Message: "No Attendances found",
			Status:  404,
		}
	}

	var attendanceDTOs []dtos.AttendanceDTOS
	for _, attendance := range attendances {
		attendanceDTOs = append(attendanceDTOs, dtos.AttendanceDTOS{
			ID:              attendance.ID,
			UserID: 		attendance.UserID,
			HeadID:          attendance.HeadID,
			Status:          attendance.Status,
			At:              attendance.At,
			SessionID:       attendance.SessionID,
			Type:            attendance.Type,
			CreatedAt:       attendance.CreatedAt,
			UpdatedAt:       attendance.UpdatedAt,
		})
	}
	return attendanceDTOs, nil
}

func (r *AttendanceUseCase) GetAttendanceByID(id string) (*dtos.AttendanceDTOS, *domain.ErrorResponse) {
	Attendance, err := r.attendanceRepository.GetAttendanceByID(id)
	if err != nil && err.Error() == "record not found" {
		return nil, &domain.ErrorResponse{
			Message: "Attendance not found",
			Status:  404,
		}
	}

	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to retrieve Attendance",
			Status:  500,
		}
	}
	
	return &dtos.AttendanceDTOS{
		ID:              Attendance.ID,
		UserID:          Attendance.UserID,
		HeadID:          Attendance.HeadID,
		Status:          Attendance.Status,
		At:              Attendance.At,
		SessionID:       Attendance.SessionID,
		Type:            Attendance.Type,
		CreatedAt:       Attendance.CreatedAt,
		UpdatedAt:       Attendance.UpdatedAt,
	}, nil
}

func (r *AttendanceUseCase) TakeAttendance(attendance dtos.CreateAttendanceDTOS) (*dtos.AttendanceDTOS, *domain.ErrorResponse) {
	session, err := r.sessionRepository.GetSessionByID(strconv.Itoa(attendance.SessionID))
	if err != nil && session == nil {
		return &dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Session not found",
			Status:  404,
		}
	}
	if err != nil {
		return &dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Failed to take attendance",
			Status:  500,
		}
	}

	user, err := r.userRepository.GetUserByID( r.context, attendance.UserID)
	if err != nil && (user == domain.User{}) {
		return &dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "User not found",
			Status:  404,
		}
	}

	if err != nil {
		return &dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Failed to take attendance",
			Status:  500,
		}
	}

	existingAttendance, err := r.attendanceRepository.GetAttendanceBySessionIDAndUserID(attendance.SessionID, attendance.UserID)

	if err == nil && existingAttendance != nil {
		return &dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Attendance already exists for this user",
			Status:  400,
		}
	}

	newAttendance, err := r.attendanceRepository.TakeAttendance(attendance)
	if err != nil {
		return &dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Failed to create Attendance",
			Status:  500,
		}
	}

	return &dtos.AttendanceDTOS{
		ID:              newAttendance.ID,
		UserID:          newAttendance.UserID,
		HeadID:          newAttendance.HeadID,
		Status:          newAttendance.Status,
		At:              newAttendance.At,
		SessionID:       newAttendance.SessionID,
		Type:            newAttendance.Type,
		CreatedAt:       newAttendance.CreatedAt,
		UpdatedAt:       newAttendance.UpdatedAt,
	}, nil
}

func (r *AttendanceUseCase) TakeMassAttendance(attendances dtos.CreateMassAttendanceDTOS) ([]dtos.AttendanceDTOS, *domain.ErrorResponse) {
	if len(attendances.UserIDs) == 0 {
		return []dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "No users provided",
			Status:  400,
		}
	}
	session, err := r.sessionRepository.GetSessionByID(strconv.Itoa(attendances.SessionID))
	if err != nil && session == nil {
		return []dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Session not found",
			Status:  404,
		}
	}
	if err != nil {
		return []dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Failed to take attendance",
			Status:  500,
		}
	}

	for _, userID := range attendances.UserIDs {
		user, err := r.userRepository.GetUserByID(r.context, userID)
		if err != nil && (user == domain.User{}) {
			return []dtos.AttendanceDTOS{}, &domain.ErrorResponse{
				Message: "User not found",
				Status:  404,
			}
		}
		if err != nil {
			return []dtos.AttendanceDTOS{}, &domain.ErrorResponse{
				Message: "Failed to take attendance",
				Status:  500,
			}
		}
	}
	
	newAttendances, err := r.attendanceRepository.TakeMassAttendance(attendances)
	if err != nil {
		return []dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Failed to create Attendance",
			Status:  500,
		}
	}

	if newAttendances == nil {
		return []dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Attendance already exists.",
			Status:  400,
		}
	}

	var attendanceDtos []dtos.AttendanceDTOS

	for _, attendance := range newAttendances {
		attendanceDtos = append(attendanceDtos, dtos.AttendanceDTOS{
			ID:             attendance.ID,
			UserID:          attendance.UserID,
			HeadID:          attendance.HeadID,
			Status:          attendance.Status,
			At:              attendance.At,
			SessionID:       attendance.SessionID,
			Type:            attendance.Type,
			CreatedAt:       attendance.CreatedAt,
			UpdatedAt:       attendance.UpdatedAt,
		})
	}

	return attendanceDtos, nil
}

func (r *AttendanceUseCase) UpdateAttendance(id string, attendance dtos.UpdateAttendanceDTOS) (*dtos.AttendanceDTOS, *domain.ErrorResponse) {
	existingAttendance, err := r.attendanceRepository.GetAttendanceByID(id)
	if err != nil && err.Error() == "record not found" {
		return nil, &domain.ErrorResponse{
			Message: "Attendance not found",
			Status:  404,
		}
	}

	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to retrieve Attendance",
			Status:  500,
		}
	}

	if attendance.SessionID != 0 {
		existingAttendance.SessionID = attendance.SessionID
	}

	if attendance.Type != 0 {
	 existingAttendance.Type = attendance.Type
	}

	if attendance.Status != 0 {
		existingAttendance.Status = attendance.Status
	}

	existingAttendance.UpdatedAt = time.Now()

	if err := r.attendanceRepository.UpdateAttendance(existingAttendance); err != nil {
		return &dtos.AttendanceDTOS{}, &domain.ErrorResponse{
			Message: "Failed to update Attendance",
			Status: 500,
		}
	}
	return &dtos.AttendanceDTOS{
		ID:             existingAttendance.ID,
		UserID:         existingAttendance.UserID,
		HeadID:         existingAttendance.HeadID,
		Status:         existingAttendance.Status,
		At:             existingAttendance.At,
		SessionID:      existingAttendance.SessionID,
		Type:           existingAttendance.Type,
		CreatedAt:      existingAttendance.CreatedAt,
		UpdatedAt:      existingAttendance.UpdatedAt,
	}, nil
}

func (r *AttendanceUseCase) DeleteAttendance(id string) *domain.ErrorResponse {
	attendance, err := r.attendanceRepository.GetAttendanceByID(id)

	if err != nil && err.Error() == "record not found" {
		return &domain.ErrorResponse{
			Message: "Attendance not found",
			Status:  404,
		}
	}
	if err != nil {
		return &domain.ErrorResponse{
			Message: "Failed to retrieve Attendance",
			Status:  500,
		}
	}
	if err := r.attendanceRepository.DeleteAttendance(attendance); err != nil {
		return &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}
	return nil
}