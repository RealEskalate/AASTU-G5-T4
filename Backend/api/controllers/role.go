package controllers

import (
	"A2SVHUB/internal/domain"

	"github.com/gin-gonic/gin"
)

type RoleController struct {
	roleUseCase domain.RoleUseCaseInterface
}


func NewRoleController(roleUseCase domain.RoleUseCaseInterface) *RoleController {
	return &RoleController{
		roleUseCase: roleUseCase,
	}
}

func (r RoleController) GetRole(c *gin.Context) {
	roleID := c.Param("id")
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
	var role domain.Role
	if err := c.ShouldBindJSON(&role); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input",
			Status:  400,
		})
		return
	}
	if err := r.roleUseCase.CreateRole(&role); err != nil {
		c.JSON(500, domain.ErrorResponse{
			Message: "Failed to create role",
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
	var role domain.Role
	if err := c.ShouldBindJSON(&role); err != nil {
		c.JSON(400, domain.ErrorResponse{
			Message: "Invalid input",
			Status:  400,
		})
		return
	}

	if err := r.roleUseCase.UpdateRole(&role); err != nil {
		c.JSON(500, domain.ErrorResponse{
			Message: "Failed to update role",
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
