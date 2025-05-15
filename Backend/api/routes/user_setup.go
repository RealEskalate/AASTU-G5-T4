package routes

import (
	// "A2SVHUB/api/controllers"

	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/middleware"
	"A2SVHUB/pkg/utils"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupUserGroup(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB, tokenService *utils.TokenService) {
	userRepo := repositories.NewUserRepository(db)
	submissionRepo := repositories.NewSubmissionRepository(db)

	userUseCase := usecases.NewUserUseCase(userRepo)
	submissionUseCase := usecases.NewSubmissionUseCase(submissionRepo)

	userController := controllers.NewUserController(userUseCase, submissionUseCase)

	// Middleware
	authMiddleware := middleware.AuthMiddleware(tokenService)
	api.Use(authMiddleware)

	api.GET("", userController.GetAllUsers)
	api.POST("", userController.CreateUser)

	api.GET("/:id", userController.GetUserByID)
	api.GET("/:id/submissions", userController.GetUserSubmissions)

	api.PUT("/:id", userController.UpdateUser)
	api.DELETE("/:id", userController.DeleteUser)

	api.POST("/bulk", userController.CreateUsers)
	api.GET("/users/group/:group_id", userController.GetUsersByGroup)

	api.POST("/users/:id/avatar", userController.UploadUserImage)

}
