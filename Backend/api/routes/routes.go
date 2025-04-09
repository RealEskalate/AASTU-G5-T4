package routes

import (
	"github.com/gin-gonic/gin"
)

func SetupRoutes(r *gin.Engine) {
	// Group API routes
	api := r.Group("/api")
	{
		// Setup individual groups
		SetupUserGroup(api.Group("/user"))
		SetupTrackGroup(api.Group("/track"))
		SetupRoleGroup(api.Group("/group"))
		SetupCountryGroup(api.Group("/country"))
		SetupGroupGroup(api.Group("/group"))
		SetupInviteGroup(api.Group("/invite"))
		SetupProblemGroup(api.Group("/problem"))
	}
}
