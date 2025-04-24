package controllers

import (
	"A2SVHUB/internal/domain"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type RatingController struct {
	useCase domain.RatingUseCase
}

func NewRatingController(useCase domain.RatingUseCase) *RatingController {
	return &RatingController{useCase: useCase}
}

func (c *RatingController) GenerateRatings(ctx *gin.Context) {
	idParam := ctx.Param("contest_id")
	contestID, err := strconv.Atoi(idParam)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid contest ID"})
		return
	}

	err = c.useCase.GenerateRatings(ctx.Request.Context(), contestID)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "Ratings generated successfully"})
}

func (rc *RatingController) GetAllRatings(c *gin.Context) {
	contestID, err := strconv.Atoi(c.Param("contest_id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid contest ID", Status: 400})
		return
	}

	ratings, err := rc.useCase.GetAllRatings(c.Request.Context(), contestID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{Message: "Ratings retrieved successfully", Data: ratings, Status: 200})
}


func (rc *RatingController) GetRatingByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid ID", Status: 400})
		return
	}

	rating, err := rc.useCase.GetRatingByID(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusNotFound, domain.ErrorResponse{Message: "Rating not found", Status: 404})
		return
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{Message: "Rating retrieved successfully", Data: rating, Status: 200})
}
