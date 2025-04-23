package controllers

import (
    "A2SVHUB/internal/domain"
    "context"
    "fmt"
    "strconv"

    "github.com/gin-gonic/gin"
)

type SubmissionController struct {
    SubmissionUseCase domain.SubmissionUseCase
}

func NewSubmissionController(suc domain.SubmissionUseCase) *SubmissionController {
    return &SubmissionController{
        SubmissionUseCase: suc,
    }
}

// CreateSubmission handles the creation of a new submission.
func (sc *SubmissionController) CreateSubmission(c *gin.Context) {
    var submission domain.Submission
    if err := c.ShouldBindJSON(&submission); err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid request body",
        })
        return
    }

    createdSubmission, err := sc.SubmissionUseCase.CreateSubmission(context.TODO(), submission)
    if err != nil {
        c.JSON(500, gin.H{
            "detail": fmt.Sprintf("Failed to create submission: %v", err),
        })
        return
    }

    c.JSON(201, gin.H{
        "submission": createdSubmission,
    })
}

// GetSubmissionByID retrieves a submission by its ID.
func (sc *SubmissionController) GetSubmissionByID(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format",
        })
        return
    }

    submission, err := sc.SubmissionUseCase.GetSubmissionByID(context.TODO(), idInt)
    if err != nil {
        c.JSON(404, gin.H{
            "detail": fmt.Sprintf("Submission not found: %v", err),
        })
        return
    }

    c.JSON(200, gin.H{
        "submission": submission,
    })
}

// GetSubmissionsByProblem retrieves all submissions for a specific problem.
func (sc *SubmissionController) GetSubmissionsByProblem(c *gin.Context) {
    problemID := c.Query("problemID")
    problemIDInt, err := strconv.Atoi(problemID)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid problem ID format",
        })
        return
    }

    submissions, err := sc.SubmissionUseCase.GetSubmissionsByProblem(context.TODO(), problemIDInt)
    if err != nil {
        c.JSON(404, gin.H{
            "detail": fmt.Sprintf("No submissions found: %v", err),
        })
        return
    }

    c.JSON(200, gin.H{
        "submissions": submissions,
    })
}

// UpdateSubmission updates an existing submission.
func (sc *SubmissionController) UpdateSubmission(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format",
        })
        return
    }

    var submission domain.Submission
    if err := c.ShouldBindJSON(&submission); err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid request body",
        })
        return
    }
    submission.ID = idInt

    updatedSubmission, err := sc.SubmissionUseCase.UpdateSubmission(context.TODO(), submission)
    if err != nil {
        c.JSON(500, gin.H{
            "detail": fmt.Sprintf("Failed to update submission: %v", err),
        })
        return
    }

    c.JSON(200, gin.H{
        "submission": updatedSubmission,
    })
}

// DeleteSubmission deletes a submission by its ID.
func (sc *SubmissionController) DeleteSubmission(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format",
        })
        return
    }

    if err := sc.SubmissionUseCase.DeleteSubmission(context.TODO(), idInt); err != nil {
        c.JSON(500, gin.H{
            "detail": fmt.Sprintf("Failed to delete submission: %v", err),
        })
        return
    }

    c.JSON(204, nil)
}