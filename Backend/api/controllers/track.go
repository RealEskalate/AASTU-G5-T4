package controllers

import (
	"github.com/gin-gonic/gin"
)

func GetTrack(c *gin.Context) {
	c.JSON(200, gin.H{
		"track": "This is the track endpoint",
	})
}
