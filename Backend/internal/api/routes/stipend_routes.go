package routes

import (
	"A2SVHUB/internal/api/handlers"

	"github.com/gin-gonic/gin"
)

func SetupStipendRoutes(router *gin.RouterGroup, handler *handlers.StipendHandler) {
	stipends := router.Group("/stipends")
	{
		stipends.POST("", handler.CreateStipend)
		stipends.GET("/:id", handler.GetStipend)
		stipends.GET("/user/:user_id", handler.GetStipendsByUser)
		stipends.GET("/session/:session_id", handler.GetStipendsBySession)
		stipends.PUT("/:id", handler.UpdateStipend)
		stipends.DELETE("/:id", handler.DeleteStipend)
	}
}
