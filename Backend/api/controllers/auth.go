package controllers

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"net/http"

	"github.com/gin-gonic/gin"
)

type AuthController struct {
	authUseCase domain.AuthUseCase
}

func NewAuthController(authUseCase domain.AuthUseCase) *AuthController {
	return &AuthController{
		authUseCase: authUseCase,
	}
}

func (ac *AuthController) Login(c *gin.Context) {
	var request dtos.LoginRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{
			Message: "Invalid request body",
			Status:  400,
		})
		return
	}

	response, err := ac.authUseCase.Login(request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "Login successful",
		Data:    response,
		Status:  200,
	})
}
