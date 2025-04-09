package controllers

import (
	"github.com/gin-gonic/gin"
)

func GetRole(c *gin.Context) {
	c.JSON(200, gin.H{
		"role": "This is the role endpoint",
	})
}
