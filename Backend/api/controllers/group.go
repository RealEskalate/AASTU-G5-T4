package controllers

import (
	"github.com/gin-gonic/gin"
)

func Group(c *gin.Context) {
	c.JSON(200, gin.H{
		"group": "A2SV",
	})
}
