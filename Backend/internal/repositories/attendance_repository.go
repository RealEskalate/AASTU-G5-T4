package repositories

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"fmt"
	"time"

	"context"

	"gorm.io/gorm"
)

type AttendanceRepository struct {
	DB *gorm.DB
	context context.Context
}

func NewAttendanceRepository(db *gorm.DB, context context.Context) *AttendanceRepository {
	return &AttendanceRepository{
		DB: db,
		context: context,
	}
}

func (r *AttendanceRepository) GetAttendanceBySessionIDAndUserID(sessionID, userID int) (*domain.Attendance, error) {
	var attendance domain.Attendance
	if err := r.DB.WithContext(r.context).Where("session_id = ? AND user_id = ?", sessionID, userID).First(&attendance).Error; err != nil {
		return nil, err
	}
	return &attendance, nil
}

func (r *AttendanceRepository) TakeAttendance(attendance dtos.CreateAttendanceDTOS) (*domain.Attendance, error) {
	var newAttendance = domain.Attendance{
		SessionID: attendance.SessionID,
		HeadID:  attendance.HeadID,
		UserID:    attendance.UserID,
		Status:   attendance.Status,
		Type:     attendance.Type,
		At:       time.Now(),
	}
	if err := r.DB.WithContext(r.context).Create(&newAttendance).Error; err != nil {
		return nil, err
	}
	return &newAttendance, nil
}

func (r *AttendanceRepository) TakeMassAttendance(attendances dtos.CreateMassAttendanceDTOS) ([]domain.Attendance, error) {
	var userAttendances []domain.Attendance

    err := r.DB.WithContext(r.context).Transaction(func(tx *gorm.DB) error {
        var existingAttendance []domain.Attendance
		if err := tx.Where("session_id = ? AND user_id IN ?", attendances.SessionID, attendances.UserIDs).Find(&existingAttendance).Error; err != nil {
			return fmt.Errorf("failed to check existing attendance: %v", err)
		}
		existingAttendanceMap := make(map[int]bool)
		for _, attendance := range existingAttendance {
			existingAttendanceMap[attendance.UserID] = true
		}
		
		for _, userID := range attendances.UserIDs {
			if existingAttendanceMap[userID] {
				continue
			}
			newAttendance := domain.Attendance{
				SessionID: attendances.SessionID,
				HeadID:    attendances.HeadID,
				UserID:    userID,
				Status:    attendances.Status,
				Type:      attendances.Type,
				At:        time.Now(),
			}

			if err := tx.Create(&newAttendance).Error; err != nil {
				return fmt.Errorf("failed to create attendance for user %d: %v", userID, err)
			}

			userAttendances = append(userAttendances, newAttendance)
		}
        return nil
    })

    if err != nil {
        return nil, err
    }

    return userAttendances, nil
}

func (r *AttendanceRepository) GetAllAttendances(filters map[string]interface{}) ([]domain.Attendance, error) {
    var attendances []domain.Attendance

    query := r.DB.WithContext(r.context)

	limit, ok := filters["limit"].(int)
    if !ok || limit <= 0 {
        limit = 50
    }

    page, ok := filters["page"].(int)
    if !ok || page <= 0 {
        page = 1
    }

    delete(filters, "limit")
    delete(filters, "page")

	if sessionID, ok := filters["session_id"].(int); ok {
		query = query.Where("session_id = ?", sessionID)
	}

	if userID, ok := filters["user_id"].(int); ok {
		query = query.Where("user_id = ?", userID)
	}

	if headID, ok := filters["head_id"].(int); ok {
		query = query.Where("head_id = ?", headID)
	}

	if status, ok := filters["status"].(int); ok {
		query = query.Where("status = ?", status)
	}

	if attendanceType, ok := filters["type"].(int); ok {
		query = query.Where("type = ?", attendanceType)
	}

    offset := (page - 1) * limit
    query = query.Limit(limit).Offset(offset)
    if err := query.Find(&attendances).Error; err != nil {
        return nil, err
    }
    return attendances, nil
}

func (r *AttendanceRepository) GetAttendanceByID(id string) (*domain.Attendance, error) {
	var attendance domain.Attendance
	if err := r.DB.WithContext(r.context).First(&attendance, id).Error; err != nil {
		return nil, err
	}
	return &attendance, nil
}


func (r *AttendanceRepository) UpdateAttendance(attendance *domain.Attendance) error {
	if err := r.DB.WithContext(r.context).Save(attendance).Error; err != nil {
		return err
	}
	return nil
}

func (r *AttendanceRepository) DeleteAttendance(attendance *domain.Attendance) error {
	if err := r.DB.WithContext(r.context).Delete(&attendance).Error; err != nil {
		return err
	}
	return nil
}