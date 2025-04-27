package controllers

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"strconv"

	"github.com/gin-gonic/gin"
)

type SessionController struct {
	sessionUseCase domain.SessionUseCase
}

func NewSessionController(sessionUseCase domain.SessionUseCase) *SessionController {
	return &SessionController{
		sessionUseCase: sessionUseCase,
	}
}

func (r SessionController) GetSession(c *gin.Context) {
	sessionID := c.Param("id")
	if sessionID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "Session ID is required",
			Status:  400,
		})
		return
	}
	session, err := r.sessionUseCase.GetSessionByID(sessionID)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status: err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Session retrieved successfully",
		Data:    session,
		Status:  200,
	})
}

func (r SessionController) CreateSession(c *gin.Context) {
	var request dtos.CreateSessionDTOS
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input: :" + err.Error(),
			Status:  400,
		})
		return
	}
	session , err := r.sessionUseCase.CreateSession(request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(201, domain.SuccessResponse{
		Message: "Session created successfully",
		Data:    session,
		Status:  201,
	})
}

func (r SessionController) UpdateSession(c *gin.Context) {
	var request dtos.UpdateSessionDTOS
	sessionID := c.Param("id")
	if sessionID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "Session ID is required",
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

	session, err := r.sessionUseCase.UpdateSession(sessionID, request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Session updated successfully",
		Data:    session,
		Status:  200,
	})
}

func (r SessionController) DeleteSession(c *gin.Context) {
	sessionID := c.Param("id")

	if sessionID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "Session ID is required",
			Status:  400,
		})
		return
	}
	if err := r.sessionUseCase.DeleteSession(sessionID); err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(204, domain.SuccessResponse{
		Message: "Session deleted successfully",
		Data:    nil,
		Status:  204,
	})
}

func (r SessionController) GetAllSessions(c *gin.Context) {
	filter := make(map[string]interface{})
	allowedFilters := []string{"start_time", "end_time", "location", "lecturer_id"}

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
	
	sessions, err := r.sessionUseCase.GetAllSessions(filter)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Sessions retrieved successfully",
		Data:    sessions,
		Status:  200,
	})
}

func (r SessionController) GetSessionByLecturer(c *gin.Context) {
	lecturer_id := c.Query("lecturer_id")
	if lecturer_id == ""{
		c.JSON(400, domain.ErrorResponse{
			Message: "Lecturer ID is required",
			Status:  400,
		})
		return
	}
	lecturer_id_int, _ := strconv.Atoi(lecturer_id)

	session, err := r.sessionUseCase.GetSessionByLecturer(lecturer_id_int)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Sessions retrieved successfully",
		Data:    session,
		Status:  200,
	})
}
