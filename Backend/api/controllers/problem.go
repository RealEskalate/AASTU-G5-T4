package controllers

import (
	"A2SVHUB/internal/domain"
	"context"
	"log"
	"strconv"

	"github.com/gin-gonic/gin"
)

type ProblemController struct {
	ProblemUseCase domain.ProblemUseCase
}

func NewProblemController(ProblemUseCase domain.ProblemUseCase) *ProblemController {
	return &ProblemController{
		ProblemUseCase: ProblemUseCase,
	}
}

func (pc *ProblemController) CreateProblem(c *gin.Context) {
	var problem struct {
		ContestID  *int   `json:"contest_id" binding:"omitempty"`
		TrackID    *int   `json:"track_id" binding:"omitempty"`
		Name       string `json:"name"`
		Difficulty string `json:"difficulty" binding:"omitempty,oneof=easy medium hard none"`
		Tag        string `json:"tag" binding:"omitempty"`
		Platform   string `json:"platform"`
		Link       string `json:"link"`
	}

	if err := c.ShouldBindJSON(&problem); err != nil {
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}

	domainProblem := domain.Problem{
		ContestID:  problem.ContestID,
		TrackID:    problem.TrackID,
		Name:       problem.Name,
		Difficulty: problem.Difficulty,
		Tag:        problem.Tag,
		Platform:   problem.Platform,
		Link:       problem.Link,
	}

	new_problem, err := pc.ProblemUseCase.CreateProblem(context.TODO(), domainProblem)
	if err != nil {
		println("Error creating problem:", err.Error())
		c.JSON(500, gin.H{
			"detail": "Failed to create problem",
			"error":  err.Error(),
		})
		return
	}
	c.JSON(201, gin.H{
		"problem": new_problem,
	})
}

func (pc *ProblemController) GetProblemByID(c *gin.Context) {
	id := c.Param("id")
	id_int, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(400, gin.H{"error": "none valid id, id must be a number"})
	}

	if err != nil {
		c.JSON(400, gin.H{"error": "Invalid ID format"})
		return
	}

	problem, err := pc.ProblemUseCase.GetProblemByID(context.TODO(), id_int)
	if err != nil {
		c.JSON(404, gin.H{"error": "Problem not found"})
		return
	}

	c.JSON(200, gin.H{"problem": problem})
}

func (pc *ProblemController) UpdateProblem(c *gin.Context) {

	var problemUpdate struct {
		ContestID  *int   `json:"contest_id" binding:"omitempty"`
		TrackID    *int   `json:"track_id" binding:"omitempty"`
		Name       string `json:"name" binding:"omitempty"`
		Difficulty string `json:"difficulty" binding:"omitempty,oneof=easy medium hard none"`
		Tag        string `json:"tag" binding:"omitempty"`
		Platform   string `json:"platform" binding:"omitempty"`
		Link       string `json:"link" binding:"omitempty"`
	}

	id := c.Param("id")
	id_int, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(400, gin.H{"error": "none valid id, id must be a number"})
		return
	}

	if err := c.ShouldBindJSON(&problemUpdate); err != nil {
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}

	domainProblem := domain.Problem{
		ContestID:  problemUpdate.ContestID,
		TrackID:    problemUpdate.TrackID,
		Name:       problemUpdate.Name,
		Difficulty: problemUpdate.Difficulty,
		Tag:        problemUpdate.Tag,
		Platform:   problemUpdate.Platform,
		Link:       problemUpdate.Link,
	}

	err = pc.ProblemUseCase.UpdateProblem(context.TODO(), id_int, domainProblem)
	if err != nil {
		log.Fatalf("update failed: %v", err.Error())
		c.JSON(500, gin.H{"details": "Failed to update problem", "error": err.Error()})
		return
	}

	c.JSON(200, gin.H{"r": "problem updated"})
}

func (pc *ProblemController) DeleteProblem(c *gin.Context) {
	id := c.Param("id")
	id_int, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(400, gin.H{"error": "none valid id, id must be a number"})
		return
	}
	err = pc.ProblemUseCase.DeleteProblem(context.TODO(), id_int)
	if err != nil {
		c.JSON(500, gin.H{"error": "Failed to delete problem"})
		return
	}

	c.JSON(204, nil)
}

func (pc *ProblemController) GetProblems(c *gin.Context) {
	filter := make(map[string]interface{})
	allowedFilters := []string{"tag", "difficulty", "platform", "contest_id"}

	// Extract filters from query parameters
	for _, key := range allowedFilters {
		if value := c.Query(key); value != "" {
			filter[key] = value
		}
	}
	// Check if "limit" and "page" are in the filter, convert them to numbers, or assign default values
	limit := 50 // Default limit
	page := 1   // Default page

	if limitStr := c.Query("limit"); limitStr != "" {
		if parsedLimit, err := strconv.Atoi(limitStr); err == nil {
			limit = parsedLimit
		} else {
			c.JSON(400, gin.H{"error": "Invalid limit value, must be a number"})
			return
		}
	}

	if pageStr := c.Query("page"); pageStr != "" {
		if parsedPage, err := strconv.Atoi(pageStr); err == nil {
			page = parsedPage
		} else {
			c.JSON(400, gin.H{"error": "Invalid page value, must be a number"})
			return
		}
	}

	filter["limit"] = limit
	filter["page"] = page

	// Extract the name query parameter
	name := c.Query("name")

	// Use the use case to get problems by name and filters
	problems, err := pc.ProblemUseCase.GetProblemsByNameAndFilters(context.TODO(), name, filter)
	if err != nil {
		log.Printf("Error fetching problems: %v", err.Error())
		c.JSON(500, gin.H{"details": "Failed to fetch problems", "error": err.Error()})
		return
	}

	c.JSON(200, gin.H{"problems": problems})
}
