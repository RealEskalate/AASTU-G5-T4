package controllers

import (
	"github.com/gin-gonic/gin"
)

func Country(c *gin.Context) {
	c.JSON(200, gin.H{
		"country": "Ethiopia",
	})
}
