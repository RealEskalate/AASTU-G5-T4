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
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid group ID format. Please provide a numeric ID."})
		return
	}

	group, err := gc.useCase.GetGroupByID(context.TODO(), id)
	if err != nil {
		if err.Error() == "record not found" { // Handle the specific "record not found" error
			c.JSON(http.StatusNotFound, gin.H{"detail": "Group not found. The provided ID does not match any existing group."})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "An error occurred while retrieving the group. Please try again later.", "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"group": group})
}

// POST /groups - Create a new group
func (gc *GroupController) CreateGroup(c *gin.Context) {
	var group domain.Group
	if err := c.ShouldBindJSON(&group); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid input. Please ensure all required fields are provided and correctly formatted.", "error": err.Error()})
		return
	}

	if group.Name == "" || group.ShortName == "" || group.Description == "" || group.CountryID <= 0 {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "All required fields (Name, ShortName, Description, CountryID) must be provided and valid."})
		return
	}

	existingGroup, err := gc.useCase.GetGroupByUniqueFields(context.TODO(), group.Name, group.ShortName, group.Description)
	if err == nil && existingGroup.ID != 0 {
		c.JSON(http.StatusConflict, gin.H{"detail": "A group with the same Name, ShortName, and Description already exists."})
		return
	}

	newGroup, err := gc.useCase.CreateGroup(context.TODO(), group.Name, group.ShortName, group.Description, group.HOAID, group.CountryID)
	if err != nil {
		if err.Error() == "country not found" {
			c.JSON(http.StatusBadRequest, gin.H{"detail": "The provided CountryID does not exist. Please provide a valid CountryID."})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "An error occurred while creating the group. Please try again later.", "error": err.Error()})
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
