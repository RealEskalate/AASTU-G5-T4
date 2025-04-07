package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupRoutes(r *gin.Engine) {
	// Group API routes
	api := r.Group("/api")
	{
		// User route
		api.GET("/user", controllers.GetUser)

		// Add more routes here
		// Example: api.POST("/users", controllers.UserController.CreateUser)
	}
}
