package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupRoutes(r *gin.Engine) {
	// Group API routes
	api := r.Group("/api")
	{
		// Setup individual groups
		controllers.SetupUserGroup(api)
		controllers.SetupTrackGroup(api)
		controllers.SetupRoleGroup(api)
		controllers.SetupCountryGroup(api)
		controllers.SetupGroupGroup(api)
		controllers.SetupInviteGroup(api)
		controllers.SetupProblemGroup(api)
	}
}
