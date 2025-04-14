package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupTrackGroup(api *gin.RouterGroup) {
	track := api.Group("/track")
	track.GET("", controllers.GetTrack)
}
