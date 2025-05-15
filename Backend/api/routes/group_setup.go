package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/middleware"
	"A2SVHUB/pkg/utils"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupGroupGroup(api *gin.RouterGroup, db *gorm.DB, tokenService *utils.TokenService) {
	GroupRepo := repositories.NewGroupRepository(db)
	GroupUseCase := usecases.NewGroupUseCase(GroupRepo)
	GroupController := controllers.NewGroupController(GroupUseCase)

	// Middleware
	authMiddleware := middleware.AuthMiddleware(tokenService)
	api.Use(authMiddleware)

	api.GET("", GroupController.GetAllGroups)
	api.GET("/:id", GroupController.GetGroupByID)
	api.POST("", GroupController.CreateGroup)
	api.PUT("/:id", GroupController.UpdateGroupByID)
	api.DELETE("/:id", GroupController.DeleteGroupByID)

}
