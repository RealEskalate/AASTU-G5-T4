package controllers

import (
	"github.com/gin-gonic/gin"
)

func Problem(c *gin.Context) {
	c.JSON(200, gin.H{
		"problem": "Solve this algorithm challenge",
	})
}
