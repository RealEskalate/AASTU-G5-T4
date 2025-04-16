package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"context"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupRoleGroup(roleRoute *gin.RouterGroup, db *gorm.DB) {
	roleRepository := repositories.NewRoleRepository(db, context.TODO())
	roleUseCase := usecases.NewRoleUseCase(roleRepository)
	roleController := controllers.NewRoleController(roleUseCase)

	roleRoute.GET("/", roleController.GetAllRoles)
	roleRoute.GET("/:id", roleController.GetRole)
	roleRoute.POST("/", roleController.CreateRole)
	roleRoute.PUT("/:id", roleController.UpdateRole)
	roleRoute.DELETE("/:id", roleController.DeleteRole)

}
