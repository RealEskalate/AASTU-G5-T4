package controllers

import (
	"github.com/gin-gonic/gin"
)

func SetupUserGroup(api *gin.RouterGroup) {
	user := api.Group("/user")
	user.GET("", GetUser)
}

func GetUser(c *gin.Context) {
	c.JSON(200, gin.H{
		"user": "This is the user endpoint",
	})
}
