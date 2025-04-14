package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/usecases"

	"github.com/gin-gonic/gin"
)

func SetupCountryGroup(api *gin.RouterGroup) {
	country := api.Group("/country")
	country.GET("", func(c *gin.Context) {
		controller := controllers.NewCountryController(&usecases.CountryUseCase{})
		controller.GetAllCountries(c)
	})

	CountryController := controllers.NewCountryController(&usecases.CountryUseCase{})

	api.GET("", CountryController.GetAllCountries)
}
