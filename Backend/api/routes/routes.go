package routes

import (
	"A2SVHUB/pkg/config"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupRoutes(r *gin.RouterGroup, config *config.Config, database *gorm.DB) {

	SetupUserGroup(r.Group("/user"), config, database)

	SetupTrackGroup(r.Group("/track"))
	SetupRoleGroup(r.Group("/role"), database)
	SetupCountryGroup(r.Group("/country"))
	SetupGroupGroup(r.Group("/group"))

	superGroupRoute := r.Group("/supergroup")

	SetupSuperGroupRoute(superGroupRoute, config, database)

	SetupInviteGroup(r.Group("/invite"))
	SetupProblemGroup(r.Group("/problem"))

}
