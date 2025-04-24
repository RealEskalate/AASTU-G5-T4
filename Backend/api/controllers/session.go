package controllers

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"fmt"

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
			Message: "Invalid input",
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
		fmt.Println(err.Error())
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input",
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
	Sessions, err := r.sessionUseCase.GetAllSessions()
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Sessions retrieved successfully",
		Data:    Sessions,
		Status:  200,
	})
}