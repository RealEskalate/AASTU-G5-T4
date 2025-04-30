package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupProblem(api *gin.RouterGroup, config *config.Config, db *gorm.DB) {
	problemRepository := repositories.NewProblemRepository(*db)
	problemUseCase := usecases.NewProblemUseCase(problemRepository)
	problemController := controllers.NewProblemController(problemUseCase)

	api.POST("", problemController.CreateProblem)
	api.GET("", problemController.GetProblems)
	api.GET("/:id", problemController.GetProblemByID)
	api.PUT("/:id", problemController.UpdateProblem)
	api.DELETE("/:id", problemController.DeleteProblem)
	// problem.GET("/search/:name", problemController.SearchProblemByName)
}
