package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupConsistency(api *gin.RouterGroup, config *config.Config, db *gorm.DB) {
	consistencyRepository := repositories.NewConsistencyRepository(db)
	consistencyUseCase := usecases.NewConsistencyUseCase(consistencyRepository)
	consistencyController := controllers.NewConsistencyController(consistencyUseCase)

	api.GET("user/:id", consistencyController.GetConsistencyOfUser)
	api.GET("group/:id", consistencyController.GetConsistencyOfGroup)
}
