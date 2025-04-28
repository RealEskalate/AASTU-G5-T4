package controllers

import (
	"A2SVHUB/internal/domain"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

type ConsistencyController struct {
	ConsistencyUseCase domain.OutsideConsistencyUseCase
}

func NewConsistencyController(consistencyUseCase domain.OutsideConsistencyUseCase) *ConsistencyController {
	return &ConsistencyController{
		ConsistencyUseCase: consistencyUseCase,
	}
}

func (cc *ConsistencyController) GetConsistencyOfUser(c *gin.Context) {
	var request struct {
		ID        int       `json:"id" binding:"required,gt=0"` // ID must be greater than 0
		StartDate time.Time `json:"start_date" binding:"required"`
		EndDate   time.Time `json:"end_date" binding:"required"`
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Validate that StartDate is before EndDate
	if !request.StartDate.Before(request.EndDate) {
		c.JSON(http.StatusBadRequest, gin.H{"error": "start_date must be before end_date"})
		return
	}

	consistency := cc.ConsistencyUseCase.GetConsistencyOfUser(request.ID, request.StartDate, request.EndDate)
	c.JSON(http.StatusOK, consistency)
}

func (cc *ConsistencyController) GetConsistencyOfGroup(c *gin.Context) {
	var request struct {
		ID        int       `json:"id" binding:"required,gt=0"` // ID must be greater than 0
		StartDate time.Time `json:"start_date" binding:"required"`
		EndDate   time.Time `json:"end_date" binding:"required"`
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Validate that StartDate is before EndDate
	if !request.StartDate.Before(request.EndDate) {
		c.JSON(http.StatusBadRequest, gin.H{"error": "start_date must be before end_date"})
		return
	}

	consistencies := cc.ConsistencyUseCase.GetConsistencyOfGroup(request.ID, request.StartDate, request.EndDate)
	c.JSON(http.StatusOK, consistencies)
}
