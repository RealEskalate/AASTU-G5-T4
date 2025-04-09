package controllers

import (
	"AASTU-G5-T4/Backend/internal/domain/group"

	"github.com/gin-gonic/gin"
)

func Group(c *gin.Context) {
	c.JSON(200, gin.H{
		"group": "A2SV",
	})
}

func createGroup(c *gin.Context) {
	var group group.Group

}
