package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupContestGroup(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB) {

	contestRepo := repositories.NewContestRepository(*db)
	cacheRepo := repositories.NewCacheRepository()
	contestClient := repositories.NewContestClient()
	userRepo := repositories.NewUserRepository(*db)

	contestUseCase := usecases.NewContestUseCase(contestRepo, cacheRepo, contestClient)
	userUseCase := usecases.NewUserUseCase(userRepo)

	contestController := controllers.NewContestController(contestUseCase, userUseCase)

	api.GET("", contestController.GetAllContests)
	api.POST("", contestController.AddContest)
	api.GET("/:id/standings", contestController.GetStandings)
	api.GET("/:id/standings/refresh", contestController.RefreshStandings)
}
