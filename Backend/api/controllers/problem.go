package controllers

import (
	"github.com/gin-gonic/gin"
)

func GetProblem(c *gin.Context) {
	c.JSON(200, gin.H{
		"problem": "This is the problem endpoint",
	})
}
