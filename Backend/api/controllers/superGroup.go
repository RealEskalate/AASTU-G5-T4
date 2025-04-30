package controllers

import (
	"A2SVHUB/internal/domain"
	"context"
	"fmt"
	"strconv"

	"github.com/gin-gonic/gin"
)

type SuperGroupController struct {
	SuperGroupUseCase domain.SuperGroupUseCase
}

func NewSuperGroupController(suc domain.SuperGroupUseCase) *SuperGroupController {
	return &SuperGroupController{
		SuperGroupUseCase: suc,
	}
}

func (sc SuperGroupController) GetAllSuperGroups(c *gin.Context) {

	superGroups, err := sc.SuperGroupUseCase.GetAllSuperGroups(context.TODO())
	if err != nil {
		c.JSON(500, gin.H{
			"details": "Something went wrong",
		})
	} else {
		c.JSON(200, gin.H{
			"superGroups": superGroups,
		})
	}
}

func (sc SuperGroupController) CreateSuperGroup(c *gin.Context) {
	var requestBody struct {
		Name string `json:"name"`
	}
	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(400, gin.H{
			"detail": "invalid request body",
		})
		return
	}
	name := requestBody.Name
	if superGroup, err := sc.SuperGroupUseCase.CreateSuperGroup(context.TODO(), name); err != nil {
		c.JSON(500, gin.H{
			"detail": "Failed to create super group",
		})
	} else {
		c.JSON(201, gin.H{
			"superGroup": superGroup,
		})
	}
}

func (sc SuperGroupController) GetSuperGroupByID(c *gin.Context) {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(400, gin.H{
			"detail": "Invalid ID format",
		})
		return
	}
	superGroup, err := sc.SuperGroupUseCase.FindSuperGroupByID(context.TODO(), idInt)
	if err != nil {
		c.JSON(404, gin.H{
			"detail": "Super group not found",
		})
	} else {
		c.JSON(200, gin.H{
			"superGroup": superGroup,
		})
	}
}
func (sc SuperGroupController) GetSuperGroupByName(c *gin.Context) {
	name := c.Query("name")
	if name == "" {
		c.JSON(404, gin.H{
			"detail": "name is required",
		})
		return
	}
	superGroup, err := sc.SuperGroupUseCase.FindSuperGroupByName(context.TODO(), name)
	if err != nil {
		c.JSON(404, gin.H{
			"detail": "Super group not found",
		})
	} else {
		c.JSON(200, gin.H{
			"superGroup": superGroup,
		})
	}
}

func (sc SuperGroupController) UpdateSuperGroup(c *gin.Context) {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(400, gin.H{
			"detail": "Invalid ID format",
		})
		return
	}
	var requestBody struct {
		Name string `json:"name"`
	}
	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(400, gin.H{
			"detail": "invalid request body",
		})
		return
	}
	name := requestBody.Name
	if superGroup, err := sc.SuperGroupUseCase.UpdateSuperGroup(context.TODO(), name, idInt); err != nil {
		c.JSON(500, gin.H{
			"detail": "Failed to update super group",
		})
	} else {
		c.JSON(200, gin.H{
			"superGroup": superGroup,
		})
	}
}

func (sc SuperGroupController) DeleteSuperGroup(c *gin.Context) {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(400, gin.H{
			"detail": "Invalid ID format",
		})
		return
	}
	if err := sc.SuperGroupUseCase.DeleteSuperGroup(context.TODO(), idInt); err != nil {
		c.JSON(500, gin.H{
			"detail": fmt.Sprintf("Failed to delete super group : %v", err),
		})
	} else {
		c.JSON(204, nil)
	}
}
