package main

import (
	"log"

	"A2SVHUB/api/routes"
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/database"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	// Load configuration

	cfg := config.LoadConfig()

	// Initialize database
	db := database.ConnectDB()

	// Initialize Gin router
	router := gin.Default()

	// Enable CORS
	router.Use(cors.Default())

	// Setup routes
	routes.SetupRoutes(router.Group("/api/v0"), &cfg, db)

	// Start the HTTP server
	log.Printf("Server is running on port %s\n", cfg.AppPort)

	// schema update
	// if err := migration.MigrateModels(db); err != nil {
	// 	log.Fatalf("Migration failed: %v", err)
	// }

	if err := router.Run(cfg.AppPort); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
