package controllers

import (
	"github.com/gin-gonic/gin"
)

func Role(c *gin.Context) {
	c.JSON(200, gin.H{
		"role": "Admin",
	})
}
