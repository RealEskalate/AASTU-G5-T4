package routes

import (
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupRoutes(r *gin.RouterGroup, config *config.Config, database *gorm.DB) {

	// Setup individual groups
	SetupUserGroup(r.Group("/user"))

	SetupCountryGroup(r.Group("/country"), database)
	SetupRoleGroup(r.Group("/role"), database)
	SetupGroupGroup(r.Group("/group"), database)

	superGroupRoute := r.Group("/supergroup")
	SetupSuperGroupRoute(superGroupRoute, config, database)
	trackGroupRoute := r.Group("/track")
	SetupTrackGroup(trackGroupRoute, config, database)

	SetupInviteGroup(r.Group("/invites"), config, database)
	SetupSessionGroup(r.Group("/session"), database)

	ProblemRoute := r.Group("/problem")
	SetupProblem(ProblemRoute, config, database)

	SetupSubmissionGroup(r.Group("/submission"), config, database)

}
