package controllers

import "github.com/gin-gonic/gin"

func GetSuperGroup(c *gin.Context) {
	c.JSON(200, gin.H{
		"super_group": "This is the group endpoint",
	})
}
