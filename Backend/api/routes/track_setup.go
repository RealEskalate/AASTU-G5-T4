package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupTrackGroup(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB) {
	trackRepo := repositories.NewTrackRepository(db)
	trackUseCase := usecases.NewTrackUseCase(trackRepo)

	TrackController := controllers.NewTrackController(trackUseCase)

	api.GET("", TrackController.GetAllTracks)
	api.POST("", TrackController.CreateTrack)
	api.GET("/:id", TrackController.GetTrackByID)
	api.GET("/search", TrackController.GetTracksByName)
	api.PUT("/:id", TrackController.UpdateTrack)
	api.DELETE("/:id", TrackController.DeleteTrack)
}
