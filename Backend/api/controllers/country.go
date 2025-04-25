package controllers

import (
	"context"
	"net/http"

	"A2SVHUB/internal/domain"
	"strconv"

	"github.com/gin-gonic/gin"
)

type CountryController struct {
	useCase domain.CountryUseCase
}

func NewCountryController(useCase domain.CountryUseCase) *CountryController {
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

func (cc *CountryController) GetCountryByID(c *gin.Context) {
	countryID := c.Param("id")
	id, err := strconv.Atoi(countryID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid country ID"})
		return
	}
	country, err := cc.useCase.GetCountryByID(context.TODO(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to retrieve country"})
		return
	}
	if country.ID == 0 {
		c.JSON(http.StatusNotFound, gin.H{"detail": "Country not found"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"country": country})
}

func (cc *CountryController) CreateCountry(c *gin.Context) {
	var country domain.Country
	if err := c.ShouldBindJSON(&country); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid input"})
		return
	}
	newCountry, err := cc.useCase.CreateCountry(context.TODO(), country.Name, country.ShortCode)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to create country"})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"country": newCountry})
}

func (cc *CountryController) UpdateCountryByID(c *gin.Context) {
	countryID := c.Param("id")
	id, err := strconv.Atoi(countryID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid country ID"})
		return
	}
	var country domain.Country
	if err := c.ShouldBindJSON(&country); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid input"})
		return
	}
	updatedCountry, err := cc.useCase.UpdateCountryByID(context.TODO(), country.Name, country.ShortCode, id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to update country"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"country": updatedCountry})
}

func (cc *CountryController) DeleteCountryByID(c *gin.Context) {
	countryID := c.Param("id")
	id, err := strconv.Atoi(countryID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"detail": "Invalid country ID"})
		return
	}
	err = cc.useCase.DeleteCountryByID(context.TODO(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"detail": "Failed to delete country"})
		return
	}
	c.JSON(http.StatusNoContent, nil)
}
