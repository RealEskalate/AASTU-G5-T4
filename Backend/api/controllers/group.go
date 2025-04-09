package controllers

import (
	"github.com/gin-gonic/gin"
)

func SetupGroupGroup(api *gin.RouterGroup) {
	group := api.Group("/group")
	group.GET("", GetGroup)
}

func GetGroup(c *gin.Context) {
	c.JSON(200, gin.H{
		"group": "This is the group endpoint",
	})
}
