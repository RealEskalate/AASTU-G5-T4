package controllers

import (
	"AASTU-G5-T4/Backend/internal/domain/group"

	"github.com/gin-gonic/gin"
)

func GetGroup(c *gin.Context) {
	c.JSON(200, gin.H{
		"group": "This is the group endpoint",
	})
}

func createGroup(c *gin.Context) {
	var group group.Group

}
