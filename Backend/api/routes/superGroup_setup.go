package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupSuperGroupGroup(api *gin.RouterGroup) {
	superGroup := api.Group("/supergroup")
	superGroup.GET("/", controllers.GetSuperGroup)
}
