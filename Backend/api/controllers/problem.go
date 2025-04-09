package controllers

import (
	"github.com/gin-gonic/gin"
)

func SetupProblemGroup(api *gin.RouterGroup) {
	problem := api.Group("/problem")
	problem.GET("", GetProblem)
}

func GetProblem(c *gin.Context) {
	c.JSON(200, gin.H{
		"problem": "This is the problem endpoint",
	})
}
