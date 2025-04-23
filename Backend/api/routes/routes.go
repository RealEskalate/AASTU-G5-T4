package routes

import (
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupRoutes(r *gin.RouterGroup, config *config.Config, database *gorm.DB) {

	// Setup individual groups
	SetupUserGroup(r.Group("/user"))
	SetupTrackGroup(r.Group("/track"))
	SetupRoleGroup(r.Group("/role"))
	SetupCountryGroup(r.Group("/country"))
	SetupGroupGroup(r.Group("/group"))

	superGroupRoute := r.Group("/supergroup")
	SetupSuperGroupRoute(superGroupRoute, config, database)

	SetupInviteGroup(r.Group("/invite"))

	ProblemRoute := r.Group("/problem")
	SetupProblem(ProblemRoute, config, database)

}
