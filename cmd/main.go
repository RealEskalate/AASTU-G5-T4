package main

import (
	"A2SVHUB/api/routes"
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/database"

	"github.com/gin-gonic/gin"
)

func main() {
	// Load configuration
	config.LoadConfig()

	// Initialize database
	database.ConnectDB()

	// Setup Gin router
	r := gin.Default()

	// Setup routes
	routes.SetupRoutes(r)

	// Run server
	r.Run(config.LoadConfig().AppPort)
}
