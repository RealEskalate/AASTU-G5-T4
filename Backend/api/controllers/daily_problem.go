package controllers

import (
    "A2SVHUB/internal/domain"
    "context"
    "log"
    "strconv"
    "time"

    "github.com/gin-gonic/gin"
)

type DailyProblemController struct {
    DailyProblemUseCase domain.DailyProblemUseCase
}

func NewDailyProblemController(dailyProblemUseCase domain.DailyProblemUseCase) *DailyProblemController {
    return &DailyProblemController{
        DailyProblemUseCase: dailyProblemUseCase,
    }
}

// CreateDailyProblem handles the creation of a new daily problem.
func (dpc *DailyProblemController) CreateDailyProblem(c *gin.Context) {
    var dailyProblem struct {
        ProblemID    int       `json:"problem_id" binding:"required"`
        SuperGroupID int       `json:"super_group_id" binding:"required"`
        ForDate      time.Time `json:"for_date" binding:"required"`
    }

    if err := c.ShouldBindJSON(&dailyProblem); err != nil {
        c.JSON(400, gin.H{"error": err.Error()})
        return
    }

    domainDailyProblem := domain.DailyProblem{
        ProblemID:    dailyProblem.ProblemID,
        SuperGroupID: dailyProblem.SuperGroupID,
        ForDate:      dailyProblem.ForDate,
    }

    newDailyProblem, err := dpc.DailyProblemUseCase.CreateDailyProblem(context.TODO(), domainDailyProblem)
    if err != nil {
        log.Printf("Error creating daily problem: %v", err.Error())
        c.JSON(500, gin.H{"detail": "Failed to create daily problem", "error": err.Error()})
        return
    }

    c.JSON(201, gin.H{"daily_problem": newDailyProblem})
}

// GetDailyProblemByID retrieves a daily problem by its ID.
func (dpc *DailyProblemController) GetDailyProblemByID(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{"error": "Invalid ID format, must be a number"})
        return
    }

    dailyProblem, err := dpc.DailyProblemUseCase.GetDailyProblemByID(context.TODO(), idInt)
    if err != nil {
        c.JSON(404, gin.H{"error": "Daily problem not found"})
        return
    }

    c.JSON(200, gin.H{"daily_problem": dailyProblem})
}

// GetDailyProblemsByDate retrieves all daily problems for a specific date.
func (dpc *DailyProblemController) GetDailyProblemsByDate(c *gin.Context) {
    date := c.Query("date")
    if date == "" {
        c.JSON(400, gin.H{"error": "Date query parameter is required"})
        return
    }

    dailyProblems, err := dpc.DailyProblemUseCase.GetDailyProblemsByDate(context.TODO(), date)
    if err != nil {
        log.Printf("Error fetching daily problems: %v", err.Error())
        c.JSON(500, gin.H{"detail": "Failed to fetch daily problems", "error": err.Error()})
        return
    }

    c.JSON(200, gin.H{"daily_problems": dailyProblems})
}

// UpdateDailyProblem updates an existing daily problem.
func (dpc *DailyProblemController) UpdateDailyProblem(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{"error": "Invalid ID format, must be a number"})
        return
    }

    var dailyProblemUpdate struct {
        ProblemID    int       `json:"problem_id" binding:"omitempty"`
        SuperGroupID int       `json:"super_group_id" binding:"omitempty"`
        ForDate      time.Time `json:"for_date" binding:"omitempty"`
    }

    if err := c.ShouldBindJSON(&dailyProblemUpdate); err != nil {
        c.JSON(400, gin.H{"error": err.Error()})
        return
    }

    domainDailyProblem := domain.DailyProblem{
        ProblemID:    dailyProblemUpdate.ProblemID,
        SuperGroupID: dailyProblemUpdate.SuperGroupID,
        ForDate:      dailyProblemUpdate.ForDate,
    }

    err = dpc.DailyProblemUseCase.UpdateDailyProblem(context.TODO(), idInt, domainDailyProblem)
    if err != nil {
        log.Printf("Error updating daily problem: %v", err.Error())
        c.JSON(500, gin.H{"detail": "Failed to update daily problem", "error": err.Error()})
        return
    }

    c.JSON(200, gin.H{"message": "Daily problem updated successfully"})
}

// DeleteDailyProblem deletes a daily problem by its ID.
func (dpc *DailyProblemController) DeleteDailyProblem(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{"error": "Invalid ID format, must be a number"})
        return
    }

    err = dpc.DailyProblemUseCase.DeleteDailyProblem(context.TODO(), idInt)
    if err != nil {
        log.Printf("Error deleting daily problem: %v", err.Error())
        c.JSON(500, gin.H{"detail": "Failed to delete daily problem", "error": err.Error()})
        return
    }

    c.JSON(204, nil)
}