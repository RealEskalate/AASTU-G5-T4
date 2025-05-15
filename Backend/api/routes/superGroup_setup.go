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

func SetupSuperGroupRoute(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB, tokenService *utils.TokenService) {
	superGroupRepo := repositories.NewSuperSuperGroupRepository(*db)
	superGroupUseCase := usecases.NewSuperGroupUseCase(superGroupRepo)

	SuperGroupController := controllers.NewSuperGroupController(superGroupUseCase)

	// Middleware
	authMiddleware := middleware.AuthMiddleware(tokenService)
	api.Use(authMiddleware)

	api.GET("", SuperGroupController.GetAllSuperGroups)
	api.POST("", SuperGroupController.CreateSuperGroup)
	api.GET("/:id", SuperGroupController.GetSuperGroupByID)
	api.GET("/search", SuperGroupController.GetSuperGroupByName)
	api.PUT("/:id", SuperGroupController.UpdateSuperGroup)
	api.DELETE("/:id", SuperGroupController.DeleteSuperGroup)
}
