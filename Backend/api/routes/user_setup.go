package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupUserGroup(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB) {
	userRepo := repositories.NewUserRepository(*db)
	userUseCase := usecases.NewUserUseCase(userRepo)

	userController := controllers.NewUserController(userUseCase)

	api.GET("", userController.GetAllUsers)
	api.POST("", userController.CreateUser)
	api.GET("/:id", userController.GetUserByID)
	api.PUT("/:id", userController.UpdateUser)
	api.DELETE("/:id", userController.DeleteUser)


	api.POST("/bulk", userController.CreateUsers)
	api.GET("/users/group/:group_id", userController.GetUsersByGroup)

	api.POST("/users/:id/avatar", userController.UploadUserImage)

}
