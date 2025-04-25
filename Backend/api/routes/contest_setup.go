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

	contestUseCase := usecases.NewContestUseCase(contestRepo)

	contestController := controllers.NewContestController(contestUseCase)

	api.GET("", contestController.GetAllContests)
	api.POST("", contestController.AddContest)
	api.GET("/:id/standings", contestController.GetStandings)
}
