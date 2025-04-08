package controllers

import (
	"github.com/gin-gonic/gin"
)

func Track(c *gin.Context) {
	c.JSON(200, gin.H{
		"track": "Software Engineering",
	})
}
