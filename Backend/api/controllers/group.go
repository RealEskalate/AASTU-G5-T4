package controllers

import (
	"context"
	"net/http"
	"strconv"

	"A2SVHUB/internal/domain"

	"github.com/gin-gonic/gin"
)

type GroupController struct {
	useCase domain.GroupUseCase
}

func NewGroupController(useCase domain.GroupUseCase) *GroupController {
	return &GroupController{useCase: useCase}
}

// GET /groups - Retrieve all groups
func (gc *GroupController) GetAllGroups(c *gin.Context) {
	groups, err := gc.useCase.GetAllGroups(context.TODO())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to retrieve groups"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"groups": groups})
}

// GET /groups/:id - Retrieve a group by ID
func (gc *GroupController) GetGroupByID(c *gin.Context) {
	groupID := c.Param("id")
	id, err := strconv.Atoi(groupID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid group ID"})
		return
	}
	group, err := gc.useCase.GetGroupByID(context.TODO(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to retrieve group"})
		return
	}
	if group.ID == 0 {
		c.JSON(http.StatusNotFound, gin.H{"detail": "Group not found"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"group": group})
}

// POST /groups - Create a new group
func (gc *GroupController) CreateGroup(c *gin.Context) {
	var group domain.Group
	if err := c.ShouldBindJSON(&group); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid input"})
		return
	}
	// hoaid := 0
	// if group.HOAID != nil {
	// 	hoaid = *group.HOAID
	// }
	newGroup, err := gc.useCase.CreateGroup(context.TODO(), group.Name, group.ShortName, group.Description, group.HOAID, group.CountryID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to create group"})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"group": newGroup})
}

// PUT /groups/:id - Update a group by ID
func (gc *GroupController) UpdateGroupByID(c *gin.Context) {
	groupID := c.Param("id")
	id, err := strconv.Atoi(groupID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid group ID"})
		return
	}
	var group domain.Group
	if err := c.ShouldBindJSON(&group); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid input"})
		return
	}
	// hoaid := 0
	// if group.HOAID != nil {
	// 	hoaid = *group.HOAID
	// }
	updatedGroup, err := gc.useCase.UpdateGroupByID(context.TODO(), group.Name, group.ShortName, group.Description, group.HOAID, group.CountryID, id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to update group"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"group": updatedGroup})
}

func (gc *GroupController) DeleteGroupByID(c *gin.Context) {
	groupID := c.Param("id")
	id, err := strconv.Atoi(groupID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid group ID"})
		return
	}
	err = gc.useCase.DeleteGroupByID(context.TODO(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to delete group"})
		return
	}
	c.JSON(http.StatusNoContent, nil)
}
