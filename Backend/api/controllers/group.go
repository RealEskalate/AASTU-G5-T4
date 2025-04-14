package controllers

import (
	"github.com/gin-gonic/gin"
)

func GetGroup(c *gin.Context) {
	c.JSON(200, gin.H{
		"group": "This is the group endpoint",
	})
}
