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

func SetupProblem(api *gin.RouterGroup, config *config.Config, db *gorm.DB, tokenService *utils.TokenService) {
	problemRepository := repositories.NewProblemRepository(*db)
	problemUseCase := usecases.NewProblemUseCase(problemRepository)
	problemController := controllers.NewProblemController(problemUseCase)

	// Middleware
	authMiddleware := middleware.AuthMiddleware(tokenService)
	api.Use(authMiddleware)

	api.POST("", problemController.CreateProblem)
	api.GET("", problemController.GetProblems)
	api.GET("/:id", problemController.GetProblemByID)
	api.PUT("/:id", problemController.UpdateProblem)
	api.DELETE("/:id", problemController.DeleteProblem)
	// problem.GET("/search/:name", problemController.SearchProblemByName)
}
