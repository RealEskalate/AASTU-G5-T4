package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/utils"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupAuthGroup(authRoute *gin.RouterGroup, config *config.Config, db *gorm.DB) {
	userRepo := repositories.NewUserRepository(db)
	tokenService := utils.NewTokenService(*config)
	authUseCase := usecases.NewAuthUseCase(userRepo, *config, tokenService)
	authController := controllers.NewAuthController(authUseCase)

	authRoute.POST("/login", authController.Login)
}
