package controllers

import (
	"A2SVHUB/internal/domain"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type ContestController struct {
	useCase domain.ContestUseCase
}

func NewContestController(useCase domain.ContestUseCase) *ContestController {
	return &ContestController{useCase: useCase}
}

func (cc *ContestController) GetAllContests(c *gin.Context) {
	contests, err := cc.useCase.GetAllContests(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}
	c.JSON(http.StatusOK, domain.SuccessResponse{Message: "Contests retrieved successfully", Data: contests, Status: 200})
}

func (cc *ContestController) GetContestByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid ID", Status: 400})
		return
	}
	contest, err := cc.useCase.GetContestByID(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusNotFound, domain.ErrorResponse{Message: "Contest not found", Status: 404})
		return
	}
	c.JSON(http.StatusOK, domain.SuccessResponse{Message: "Contest retrieved successfully", Data: contest, Status: 200})
}
