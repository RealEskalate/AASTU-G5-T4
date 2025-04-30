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

func SetupInviteGroup(inviteRoute *gin.RouterGroup, config *config.Config,  db *gorm.DB) {
	inviteRepository := repositories.NewInviteRepository(db)
	tokenService := utils.NewTokenService(*config)
	emailService := utils.NewEmailService(*config)
	inviteUseCase := usecases.NewInviteUseCase(inviteRepository, *config, tokenService, emailService)
	inviteController := controllers.NewInviteController(inviteUseCase)

	inviteRoute.POST("", inviteController.InviteUser)
	inviteRoute.POST("/batch", inviteController.InviteUsers)
	inviteRoute.POST("/user", inviteController.InviteExistingUser)
	inviteRoute.GET("/:id", inviteController.AcceptInvite)
}
