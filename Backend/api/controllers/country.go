package controllers

import (
	"context"
	"net/http"

	"A2SVHUB/internal/usecases"

	"github.com/gin-gonic/gin"
)

type CountryController struct {
	useCase *usecases.CountryUseCase
}

func NewCountryController(useCase *usecases.CountryUseCase) *CountryController {
	return &CountryController{useCase: useCase}
}

// GET /countries - Retrieve all countries
func (cc *CountryController) GetAllCountries(c *gin.Context) {
	countries, err := cc.useCase.GetAllCountries(context.TODO())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to retrieve countries"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"countries": countries})
}
