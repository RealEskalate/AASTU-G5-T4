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
		api.Group("/user", controllers.GetUser)
		api.Group("/track", controllers.Track)
		api.Group("/role", controllers.Role)
		api.Group("/country", controllers.Country)
		api.Group("/group", controllers.Group)
		api.Group("/invite", controllers.Invite)
		api.Group("/problem", controllers.Problem)

		// Add more routes here
		// Example: api.POST("/users", controllers.UserController.CreateUser)
	}
}
