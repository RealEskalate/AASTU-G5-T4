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
            "detail": "Invalid request body. Ensure all required fields are provided and correctly formatted.",
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
        "message": "Submission created successfully.",
        "submission": createdSubmission,
    })
}

// GetSubmissionByID retrieves a submission by its ID.
func (sc *SubmissionController) GetSubmissionByID(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format. ID must be a positive integer.",
        })
        return
    }

    submission, err := sc.SubmissionUseCase.GetSubmissionByID(context.TODO(), idInt)
    if err != nil {
        if err.Error() == "submission not found" {
            c.JSON(404, gin.H{
                "detail": fmt.Sprintf("Submission with ID %d not found.", idInt),
            })
        } else {
            c.JSON(500, gin.H{
                "detail": fmt.Sprintf("Failed to retrieve submission: %v", err),
            })
        }
        return
    }

    c.JSON(200, gin.H{
        "message": "Submission retrieved successfully.",
        "submission": submission,
    })
}

// GetSubmissionsByProblem retrieves all submissions for a specific problem.
func (sc *SubmissionController) GetSubmissionsByProblem(c *gin.Context) {
    problemID := c.Query("problemID")
    problemIDInt, err := strconv.Atoi(problemID)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid problem ID format. Problem ID must be a positive integer.",
        })
        return
    }

    submissions, err := sc.SubmissionUseCase.GetSubmissionsByProblem(context.TODO(), problemIDInt)
    if err != nil {
        if err.Error() == "no submissions found for the given problem" {
            c.JSON(404, gin.H{
                "detail": fmt.Sprintf("No submissions found for problem ID %d.", problemIDInt),
            })
        } else {
            c.JSON(500, gin.H{
                "detail": fmt.Sprintf("Failed to retrieve submissions: %v", err),
            })
        }
        return
    }

    c.JSON(200, gin.H{
        "message": "Submissions retrieved successfully.",
        "submissions": submissions,
    })
}

// UpdateSubmission updates an existing submission.
func (sc *SubmissionController) UpdateSubmission(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format. ID must be a positive integer.",
        })
        return
    }

    var submission domain.Submission
    if err := c.ShouldBindJSON(&submission); err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid request body. Ensure all required fields are provided and correctly formatted.",
        })
        return
    }
    submission.ID = idInt

    updatedSubmission, err := sc.SubmissionUseCase.UpdateSubmission(context.TODO(), submission)
    if err != nil {
        if err.Error() == "submission not found" {
            c.JSON(404, gin.H{
                "detail": fmt.Sprintf("Submission with ID %d not found.", idInt),
            })
        } else {
            c.JSON(500, gin.H{
                "detail": fmt.Sprintf("Failed to update submission: %v", err),
            })
        }
        return
    }

    c.JSON(200, gin.H{
        "message": "Submission updated successfully.",
        "submission": updatedSubmission,
    })
}

// DeleteSubmission deletes a submission by its ID.
func (sc *SubmissionController) DeleteSubmission(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format. ID must be a positive integer.",
        })
        return
    }

    if err := sc.SubmissionUseCase.DeleteSubmission(context.TODO(), idInt); err != nil {
        if err.Error() == "submission not found" {
            c.JSON(404, gin.H{
                "detail": fmt.Sprintf("Submission with ID %d not found.", idInt),
            })
        } else {
            c.JSON(500, gin.H{
                "detail": fmt.Sprintf("Failed to delete submission: %v", err),
            })
        }
        return
    }

    c.JSON(204, gin.H{
        "message": fmt.Sprintf("Submission with ID %d deleted successfully.", idInt),
    })
}