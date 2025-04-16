package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupInviteGroup(api *gin.RouterGroup) {
	invite := api.Group("/invite")
	invite.GET("", controllers.GetInvite)
}
