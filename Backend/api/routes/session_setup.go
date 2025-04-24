package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"context"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupSessionGroup(sessionRoute *gin.RouterGroup, db *gorm.DB) {
	sessionRepository := repositories.NewSessionRepository(db, context.TODO())
	sessionUseCase := usecases.NewSessionUseCase(sessionRepository)
	sessionController := controllers.NewSessionController(sessionUseCase)

	sessionRoute.GET("/", sessionController.GetAllSessions)
	sessionRoute.GET("/:id", sessionController.GetSession)
	sessionRoute.POST("/", sessionController.CreateSession)
	sessionRoute.PUT("/:id", sessionController.UpdateSession)
	sessionRoute.DELETE("/:id", sessionController.DeleteSession)

}
