package controllers

import (
	"github.com/gin-gonic/gin"
)

func SetupTrackGroup(api *gin.RouterGroup) {
	track := api.Group("/track")
	track.GET("", GetTrack)
}

func GetTrack(c *gin.Context) {
	c.JSON(200, gin.H{
		"track": "This is the track endpoint",
	})
}
