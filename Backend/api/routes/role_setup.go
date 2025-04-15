package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
<<<<<<< HEAD
	"A2SVHUB/pkg/database"
=======
>>>>>>> 6a45fb130091dc737eee797a46b29ef9be51138e
	"context"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

<<<<<<< HEAD
func SetupRoleGroup(roleRoute *gin.RouterGroup) {
	roleRepository := repositories.NewRoleRepository(database.DB, context.TODO())
=======
func SetupRoleGroup(roleRoute *gin.RouterGroup, db *gorm.DB) {
	roleRepository := repositories.NewRoleRepository(db, context.TODO())
>>>>>>> 6a45fb130091dc737eee797a46b29ef9be51138e
	roleUseCase := usecases.NewRoleUseCase(roleRepository)
	roleController := controllers.NewRoleController(roleUseCase)

	roleRoute.GET("/", roleController.GetAllRoles)
	roleRoute.GET("/:id", roleController.GetRole)
	roleRoute.POST("/", roleController.CreateRole)
	roleRoute.PUT("/:id", roleController.UpdateRole)
	roleRoute.DELETE("/:id", roleController.DeleteRole)

<<<<<<< HEAD
}
=======
}
>>>>>>> 6a45fb130091dc737eee797a46b29ef9be51138e
