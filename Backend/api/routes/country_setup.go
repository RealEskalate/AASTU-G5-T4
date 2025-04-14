package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupCountryGroup(api *gin.RouterGroup) {
	country := api.Group("/country")
	country.GET("", controllers.GetCountry)
}
