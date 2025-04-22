package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupCountryGroup(api *gin.RouterGroup, db *gorm.DB) {
	countryRepo := repositories.NewCountryRepository(*db)
	countryUseCase := usecases.NewCountryUseCase(countryRepo)
	countryController := controllers.NewCountryController(countryUseCase)

	api.GET("", countryController.GetAllCountries)
	api.GET("/:id", countryController.GetCountryByID)
	api.POST("", countryController.CreateCountry)
	api.PUT("/:id", countryController.UpdateCountryByID)
	api.DELETE("/:id", countryController.DeleteCountryByID)

}
