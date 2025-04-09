package controllers

import (
	"github.com/gin-gonic/gin"
)

func GetCountry(c *gin.Context) {
	c.JSON(200, gin.H{
		"country": "This is the country endpoint",
	})
}
