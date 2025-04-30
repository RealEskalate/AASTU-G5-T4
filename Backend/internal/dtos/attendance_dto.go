package dtos

import "time"

type AttendanceDTOS struct {
	ID        int       `gorm:"primaryKey"`
	UserID    int       `gorm:"type:integer"`
	HeadID    int       `gorm:"type:integer"`
	Status    int       `gorm:"type:integer"`
	At        time.Time `gorm:"type:timestamp"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	SessionID int       `gorm:"type:integer"`
	Type      int       `gorm:"type:integer"`
}


type CreateAttendanceDTOS struct {
	UserID 	   int    `json:"user_id" binding:"required"`
	HeadID 	   int    `json:"head_id"`
	Status     int    `json:"status" binding:"required,oneof=1 2 3 4"`  // 1: Present, 2: Absent, 3: Late, 4: Excused
	SessionID  int    `json:"session_id" binding:"required"`            
	Type       int    `json:"type" binding:"required,oneof=1 0"`        // 1:Checkin, 0:Checkout
}


type CreateMassAttendanceDTOS struct {
	UserIDs   []int    `json:"user_ids" binding:"required"`
	HeadID 	   int    `json:"head_id"`
	Status     int    `json:"status" binding:"required"`
	SessionID  int    `json:"session_id" binding:"required"`
	Type       int    `json:"type" binding:"required"`
}


type UpdateAttendanceDTOS struct {
	Status     int    `json:"status"`
	SessionID  int    `json:"session_id"`
	Type       int    `json:"type"`
}
