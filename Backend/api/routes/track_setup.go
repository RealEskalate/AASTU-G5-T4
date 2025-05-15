package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/middleware"
	"A2SVHUB/pkg/utils"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupTrackGroup(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB, tokenService *utils.TokenService) {
	trackRepo := repositories.NewTrackRepository(db)
	trackUseCase := usecases.NewTrackUseCase(trackRepo)

	trackController := controllers.NewTrackController(trackUseCase)

	// Middleware
	authMiddleware := middleware.AuthMiddleware(tokenService)
	api.Use(authMiddleware)

	api.GET("", trackController.GetAllTracks)
	api.POST("", trackController.CreateTrack)
	api.GET("/:id", trackController.GetTrackByID)
	api.GET("/search", trackController.GetTracksByName)
	api.PUT("/:id", trackController.UpdateTrack)
	api.DELETE("/:id", trackController.DeleteTrack)
}
