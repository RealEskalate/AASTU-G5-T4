package controllers

import (
	"A2SVHUB/internal/domain"

	"github.com/gin-gonic/gin"
)

type RoleController struct {
	roleUseCase domain.RoleUseCase
}


func NewRoleController(roleUseCase domain.RoleUseCase) *RoleController {
	return &RoleController{
		roleUseCase: roleUseCase,
	}
}

func (r RoleController) GetRole(c *gin.Context) {
	roleID := c.Param("id")
	if roleID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "Role ID is required",
			Status:  400,
		})
		return
	}
	role, err := r.roleUseCase.GetRoleByID(roleID)
	if err != nil {
		c.JSON(404, domain.ErrorResponse{
			Message: "Role not found",
			Status: 404,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Role retrieved successfully",
		Data:    role,
		Status:  200,
	})
}


func (r RoleController) CreateRole(c *gin.Context) {
	var request struct {
		Type string `json:"type"`
	}
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input",
			Status:  400,
		})
		return
	}
	role , err := r.roleUseCase.CreateRole(request.Type)
	if err != nil {
		c.JSON(500, domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		})
		return
	}
	c.JSON(201, domain.SuccessResponse{
		Message: "Role created successfully",
		Data:    role,
		Status:  201,
	})
}

func (r RoleController) UpdateRole(c *gin.Context) {
	var request struct {
		Type string `json:"type"`
	}
	roleID := c.Param("id")
	if roleID == "" {
		c.JSON(400, domain.ErrorResponse{
			Message: "Role ID is required",
			Status:  400,
		})
		return
	}
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input",
			Status:  400,
		})
		return
	}
	role, err := r.roleUseCase.UpdateRole(request.Type, roleID)
	if err != nil {
		c.JSON(500, domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Role updated successfully",
		Data:    role,
		Status:  200,
	})
}

func (r RoleController) DeleteRole(c *gin.Context) {
	roleID := c.Param("id")
	if err := r.roleUseCase.DeleteRole(roleID); err != nil {
		c.JSON(500, domain.ErrorResponse{
			Message: "Failed to delete role",
			Status:  500,
		})
		return
	}
	c.JSON(204, domain.SuccessResponse{
		Message: "Role deleted successfully",
		Data:    nil,
		Status:  204,
	})
}

func (r RoleController) GetAllRoles(c *gin.Context) {
	roles, err := r.roleUseCase.GetAllRoles()
	if err != nil {
		c.JSON(500, domain.ErrorResponse{
			Message: "Failed to retrieve roles",
			Status:  500,
		})
		return
	}
	c.JSON(200, domain.SuccessResponse{
		Message: "Roles retrieved successfully",
		Data:    roles,
		Status:  200,
	})
}