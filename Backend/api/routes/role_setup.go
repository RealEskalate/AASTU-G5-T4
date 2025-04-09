package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupRoleGroup(api *gin.RouterGroup) {
	role := api.Group("/role")
	role.GET("", controllers.GetRole)
}
