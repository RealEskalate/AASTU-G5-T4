package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupDailyProblem(api *gin.RouterGroup, config *config.Config, db *gorm.DB) {
	// Initialize the repository, use case, and controller for DailyProblem
	dailyProblemRepository := repositories.NewDailyProblemRepository(db)
	dailyProblemUseCase := usecases.NewDailyProblemUseCase(dailyProblemRepository)
	dailyProblemController := controllers.NewDailyProblemController(dailyProblemUseCase)

	// Define the routes for DailyProblem
	api.POST("", dailyProblemController.CreateDailyProblem)
	api.GET("/:id", dailyProblemController.GetDailyProblemByID)
	api.GET("", dailyProblemController.GetDailyProblemsByDate)
	api.PUT("/:id", dailyProblemController.UpdateDailyProblem)
	api.DELETE("/:id", dailyProblemController.DeleteDailyProblem)
}
