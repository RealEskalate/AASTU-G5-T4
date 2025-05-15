package routes

import (
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/utils"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupRoutes(r *gin.RouterGroup, config *config.Config, database *gorm.DB) {
	tokenService := utils.NewTokenService(*config)

	SetupAuthGroup(r.Group("/auth"), config, database)

	SetupUserGroup(r.Group("/user"), config, database, tokenService)
	SetupContestGroup(r.Group("/contest"), config, database, tokenService)

	SetupRoleGroup(r.Group("/role"), database, tokenService)
	SetupGroupGroup(r.Group("/group"), database, tokenService)
	SetupCountryGroup(r.Group("/country"), database, tokenService)

	superGroupRoute := r.Group("/supergroup")

	SetupSuperGroupRoute(superGroupRoute, config, database, tokenService)
	trackGroupRoute := r.Group("/track")
	SetupTrackGroup(trackGroupRoute, config, database, tokenService)

	SetupInviteGroup(r.Group("/invites"), config, database, tokenService)
	SetupSessionGroup(r.Group("/session"), database, tokenService)
	SetupAttendanceGroup(r.Group("/attendance"), database, tokenService)

	ProblemRoute := r.Group("/problem")
	SetupProblem(ProblemRoute, config, database, tokenService)

	SetupSubmissionGroup(r.Group("/submission"), config, database, tokenService)

}
