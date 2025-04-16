package routes

import (
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupRoutes(r *gin.RouterGroup, config *config.Config, database *gorm.DB) {

	// Setup individual groups
	SetupUserGroup(r.Group("/user"))
<<<<<<< Updated upstream
	SetupTrackGroup(r.Group("/track"))
	SetupRoleGroup(r.Group("/role"))
=======

	SetupRoleGroup(r.Group("/role"), database)
>>>>>>> Stashed changes
	SetupCountryGroup(r.Group("/country"))
	SetupGroupGroup(r.Group("/group"))

	superGroupRoute := r.Group("/supergroup")
	SetupSuperGroupRoute(superGroupRoute, config, database)
	trackGroupRoute := r.Group("/track")
	SetupTrackGroup(trackGroupRoute, config, database)

	SetupInviteGroup(r.Group("/invite"))
	SetupProblemGroup(r.Group("/problem"))

}
