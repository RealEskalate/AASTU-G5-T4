package handlers

import (
	"A2SVHUB/internal/dtos"
	"A2SVHUB/internal/services"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type StipendHandler struct {
	stipendService services.StipendService
}

func NewStipendHandler(stipendService services.StipendService) *StipendHandler {
	return &StipendHandler{
		stipendService: stipendService,
	}
}

func (h *StipendHandler) CreateStipend(c *gin.Context) {
	var req dtos.CreateStipendRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	stipend, err := h.stipendService.CreateStipend(c.Request.Context(), &req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, stipend)
}

func (h *StipendHandler) GetStipend(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid id"})
		return
	}

	stipend, err := h.stipendService.GetStipend(c.Request.Context(), int(id))
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, stipend)
}

func (h *StipendHandler) GetStipendsByUser(c *gin.Context) {
	userID, err := strconv.ParseUint(c.Param("user_id"), 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid user id"})
		return
	}

	stipends, err := h.stipendService.GetStipendsByUser(c.Request.Context(), int(userID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, stipends)
}

func (h *StipendHandler) GetStipendsBySession(c *gin.Context) {
	sessionID, err := strconv.ParseUint(c.Param("session_id"), 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid session id"})
		return
	}

	stipends, err := h.stipendService.GetStipendsBySession(c.Request.Context(), int(sessionID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, stipends)
}

func (h *StipendHandler) UpdateStipend(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid id"})
		return
	}

	var req dtos.UpdateStipendRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	stipend, err := h.stipendService.UpdateStipend(c.Request.Context(), int(id), &req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, stipend)
}

func (h *StipendHandler) DeleteStipend(c *gin.Context) {
	id, err := strconv.ParseUint(c.Param("id"), 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid id"})
		return
	}

	if err := h.stipendService.DeleteStipend(c.Request.Context(), int(id)); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.Status(http.StatusNoContent)
}
