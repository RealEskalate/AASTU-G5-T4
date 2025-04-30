package controllers

import (
	"context"
	"net/http"

	"A2SVHUB/internal/domain"
	"strconv"
	"strings"

	// "errors"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type CountryController struct {
	useCase domain.CountryUseCase
	db      *gorm.DB
}

func NewCountryController(useCase domain.CountryUseCase, db *gorm.DB) *CountryController {
	return &CountryController{
		useCase: useCase,
		db:      db,
	}
}

// GET /countries - Retrieve all countries
func (cc *CountryController) GetAllCountries(c *gin.Context) {
	countries, err := cc.useCase.GetAllCountries(context.TODO())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to retrieve countries",
			"status": http.StatusInternalServerError})
		return
	}
	c.JSON(http.StatusOK, gin.H{"countries": countries})
}

func (cc *CountryController) GetCountryByID(c *gin.Context) {
	countryID := c.Param("id")
	id, err := strconv.Atoi(countryID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"detail": "Invalid country ID",
			"status": http.StatusBadRequest})
		return
	}
	country, err := cc.useCase.GetCountryByID(context.TODO(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to retrieve country",
			"status": http.StatusInternalServerError})
		return
	}
	if country.ID == 0 {
		c.JSON(http.StatusNotFound, gin.H{
			"detail": "Country not found",
			"status": http.StatusNotFound})
		return
	}
	c.JSON(http.StatusOK, gin.H{"country": country})
}

func (cc *CountryController) CreateCountry(c *gin.Context) {
	var country domain.Country
	if err := c.ShouldBindJSON(&country); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"detail": "Invalid input",
			"status": http.StatusBadRequest})
		return
	}

	// Check if the country already exists
	exists, err := cc.useCase.IsCountryExists(context.TODO(), country.Name, country.ShortCode)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to check if country exists",
			"status": http.StatusInternalServerError})
		return
	}
	if exists {
		c.JSON(http.StatusConflict, gin.H{
			"detail": "A country with the same Name or ShortCode already exists",
			"status": http.StatusConflict,
		})
		return
	}

	// Create the country
	newCountry, err := cc.useCase.CreateCountry(context.TODO(), country.Name, country.ShortCode)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to create country",
			"status": http.StatusInternalServerError,
		})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"country": newCountry})
}
func (cc *CountryController) UpdateCountryByID(c *gin.Context) {
	countryID := c.Param("id")
	id, err := strconv.Atoi(countryID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"detail": "Invalid country ID",
			"status": http.StatusBadRequest,
		})
		return
	}

	var country domain.Country
	if err := c.ShouldBindJSON(&country); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"detail": "Invalid input",
			"status": http.StatusBadRequest,
		})
		return
	}

	// Check if another country with the same Name or ShortCode already exists
	exists, err := cc.useCase.IsCountryExists(context.TODO(), country.Name, country.ShortCode)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to check if country exists",
			"status": http.StatusInternalServerError,
		})
		return
	}
	if exists {
		c.JSON(http.StatusConflict, gin.H{
			"detail": "A country with the same Name or ShortCode already exists",
			"status": http.StatusConflict,
		})
		return
	}

	// Proceed with the update
	updatedCountry, err := cc.useCase.UpdateCountryByID(context.TODO(), country.Name, country.ShortCode, id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to update country",
			"status": http.StatusInternalServerError,
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{"country": updatedCountry})
}

func (cc *CountryController) DeleteCountryByID(c *gin.Context) {
	countryID := c.Param("id")
	id, err := strconv.Atoi(countryID)

	var count int64
	count, err = cc.useCase.CountUsersByCountryID(context.TODO(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to check associated users",
			"status": http.StatusInternalServerError,
		})
		return
	}

	if count > 0 {
		c.JSON(http.StatusConflict, gin.H{
			"detail": "Cannot delete country: users are still assigned",
			"status": http.StatusConflict,
		})
		return
	}

	err = cc.db.Delete(&domain.Country{}, countryID).Error
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to delete country from database",
			"status": http.StatusInternalServerError,
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"detail": "Invalid country ID",
			"status": http.StatusBadRequest,
		})
		return
	}

	err = cc.useCase.DeleteCountryByID(context.TODO(), id)
	if err != nil {
		if strings.Contains(err.Error(), "associated users") {
			c.JSON(http.StatusConflict, gin.H{
				"detail": err.Error(),
				"status": http.StatusConflict,
			})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{
			"detail": "Failed to delete country",
			"status": http.StatusInternalServerError,
		})
		return
	}

	c.JSON(http.StatusNoContent, nil)
}
