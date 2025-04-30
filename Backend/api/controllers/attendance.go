package controllers

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"strconv"

	"github.com/gin-gonic/gin"
)

type AttendanceController struct {
	attendanceUseCase domain.AttendanceUseCase
}

func NewAttendanceController(attendanceUseCase domain.AttendanceUseCase) *AttendanceController {
	return &AttendanceController{
		attendanceUseCase:attendanceUseCase,
	}
}

func (r AttendanceController) GetAttendance(c *gin.Context) {
	attendanceID := c.Param("id")
	if attendanceID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "attendance ID is required",
			Status:  400,
		})
		return
	}
	attendance, err := r.attendanceUseCase.GetAttendanceByID(attendanceID)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status: err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "attendance retrieved successfully",
		Data:   attendance,
		Status:  200,
	})
}

func (r AttendanceController) TakeAttendance(c *gin.Context) {
	var request dtos.CreateAttendanceDTOS
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input: :" + err.Error(),
			Status:  400,
		})
		return
	}
	attendance , err := r.attendanceUseCase.TakeAttendance(request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(201, domain.SuccessResponse{
		Message: "attendance created successfully",
		Data:   attendance,
		Status:  201,
	})
}

func (r AttendanceController) TakeMassAttendance(c *gin.Context) {
	var request dtos.CreateMassAttendanceDTOS
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input: :" + err.Error(),
			Status:  400,
		})
		return
	}
	attendance , err := r.attendanceUseCase.TakeMassAttendance(request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(201, domain.SuccessResponse{
		Message: "attendance created successfully",
		Data:   attendance,
		Status:  201,
	})
}

func (r AttendanceController) UpdateAttendance(c *gin.Context) {
	var request dtos.UpdateAttendanceDTOS
	attendanceID := c.Param("id")
	if attendanceID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "attendance ID is required",
			Status:  400,
		})
		return
	}
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input: :" + err.Error(),
			Status:  400,
		})
		return
	}

	attendance, err := r.attendanceUseCase.UpdateAttendance(attendanceID, request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "attendance updated successfully",
		Data:   attendance,
		Status:  200,
	})
}

func (r AttendanceController) DeleteAttendance(c *gin.Context) {
	attendanceID := c.Param("id")

	if attendanceID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "attendance ID is required",
			Status:  400,
		})
		return
	}
	if err := r.attendanceUseCase.DeleteAttendance(attendanceID); err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(204, domain.SuccessResponse{
		Message: "attendance deleted successfully",
		Data:    nil,
		Status:  204,
	})
}

func (r AttendanceController) GetAllAttendances(c *gin.Context) {
	filter := make(map[string]interface{})
	allowedFilters := []string{"user_id", "head_id", "session_id", "status", "type"}

	for _, key := range allowedFilters {
		if value := c.Query(key); value != "" {
			filter[key] = value
		}
	}

	limit := 50
	page := 1

	if limitStr := c.Query("limit"); limitStr != "" {
		if parsedLimit, err := strconv.Atoi(limitStr); err == nil {
			limit = parsedLimit
		} else {
			c.JSON(400, gin.H{"error": "Invalid limit value, must be a number"})
			return
		}
	}

	if pageStr := c.Query("page"); pageStr != "" {
		if parsedPage, err := strconv.Atoi(pageStr); err == nil {
			page = parsedPage
		} else {
			c.JSON(400, gin.H{"error": "Invalid page value, must be a number"})
			return
		}
	}

	filter["limit"] = limit
	filter["page"] = page
	
	attendances, err := r.attendanceUseCase.GetAllAttendances(filter)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "attendances retrieved successfully",
		Data:   attendances,
		Status:  200,
	})
}