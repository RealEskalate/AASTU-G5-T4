package controllers

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"

	"github.com/gin-gonic/gin"
)

type InviteController struct {
	inviteUseCase domain.InviteUseCase
}

func NewInviteController(inviteUseCase domain.InviteUseCase) *InviteController {
	return &InviteController{
		inviteUseCase: inviteUseCase,
	}
}

func (i InviteController) InviteUser(c *gin.Context) {
	var request dtos.CreateInviteDTO
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input",
			Status:  400,
		})
		return
	}
	invite, err := i.inviteUseCase.CreateInvite(request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}

	c.JSON(201, domain.SuccessResponse{
		Message: "Invite created successfully",
		Data:    invite,
		Status:  201,
	})
}

func (i InviteController) InviteUsers(c *gin.Context) {
	var request dtos.CreateBatchInviteDTO
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: err.Error(),
			Status:  400,
		})
		return
	}

	invite, err := i.inviteUseCase.CreateInvites(request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  500,
		})
		return
	}

	c.JSON(201, domain.SuccessResponse{
		Message: "Invite created successfully",
		Data:    invite,
		Status:  201,
	})
}

func (i InviteController) AcceptInvite(c *gin.Context) {
	var token = c.Param("id")
	if token == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "Token is required",
			Status:  400,
		})
		return
	}

	user, err := i.inviteUseCase.AcceptInvite(token)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}

	c.JSON(200, domain.SuccessResponse{
		Message: "Invite accepted successfully",
		Data:    user,
		Status:  200,
	})
}

func (i InviteController) InviteExistingUser(c *gin.Context) {
	var request dtos.InviteExistingUserDTO

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input",
			Status:  400,
		})
		return
	}

	invite, err := i.inviteUseCase.InviteExistingUser(request)
	if err != nil {
		c.JSON(err.Status, domain.ErrorResponse{
			Message: err.Message,
			Status:  err.Status,
		})
		return
	}

	c.JSON(201, domain.SuccessResponse{
		Message: "Invite created successfully",
		Data:    invite,
		Status:  201,
	})
}