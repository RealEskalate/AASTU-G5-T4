package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/database"
	"context"

	"github.com/gin-gonic/gin"
)

func SetupRoleGroup(roleRoute *gin.RouterGroup) {
	roleRepository := repositories.NewRoleRepository(database.DB, context.TODO())
	roleUseCase := usecases.NewRoleUseCase(roleRepository)
	roleController := controllers.NewRoleController(roleUseCase)

	roleRoute.GET("/", roleController.GetAllRoles)
	roleRoute.GET("/:id", roleController.GetRole)
	roleRoute.POST("/", roleController.CreateRole)
	roleRoute.PUT("/:id", roleController.UpdateRole)
	roleRoute.DELETE("/:id", roleController.DeleteRole)

}