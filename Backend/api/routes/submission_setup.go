package routes

import (
    "A2SVHUB/api/controllers"
    "A2SVHUB/internal/repositories"
    "A2SVHUB/internal/usecases"
    "A2SVHUB/pkg/config"

    "github.com/gin-gonic/gin"
    "gorm.io/gorm"
)

func SetupSubmissionGroup(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB) {
    submissionRepo := repositories.NewSubmissionRepository(db)
    submissionUseCase := usecases.NewSubmissionUseCase(submissionRepo)

    submissionController := controllers.NewSubmissionController(submissionUseCase)

    api.POST("", submissionController.CreateSubmission)
    api.GET("/:id", submissionController.GetSubmissionByID)
    api.GET("/problem", submissionController.GetSubmissionsByProblem)
    api.PUT("/:id", submissionController.UpdateSubmission)
    api.DELETE("/:id", submissionController.DeleteSubmission)
}