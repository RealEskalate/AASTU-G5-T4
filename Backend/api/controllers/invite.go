package controllers

import (
	"github.com/gin-gonic/gin"
)

func GetInvite(c *gin.Context) {
	c.JSON(200, gin.H{
		"invite": "This is the invite endpoint",
	})
}
