package controllers

import (
	"github.com/gin-gonic/gin"
)

func Invite(c *gin.Context) {
	c.JSON(200, gin.H{
		"invite": "Invitation sent successfully",
	})
}
