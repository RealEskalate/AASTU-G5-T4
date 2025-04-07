package database

import (
<<<<<<< Updated upstream
=======
	"A2SVHUB/pkg/config"
>>>>>>> Stashed changes
	"fmt"
	"log"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
<<<<<<< Updated upstream

	"A2SVHUB/pkg/config"
=======
>>>>>>> Stashed changes
)

var DB *gorm.DB

func ConnectDB() {
<<<<<<< Updated upstream
	// Load configuration
	cfg := config.LoadConfig()

	// Format the DSN (Data Source Name) for Neon
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s",
		cfg.DBHost, cfg.DBUser, cfg.DBPassword, cfg.DBName, cfg.DBPort, cfg.SSLMode)

	// Connect to the database
	var err error
	DB, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}

	fmt.Println("Connected to database successfully")
=======
   cfg := config.LoadConfig()
   dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s", cfg.DBHost, cfg.DBUser, cfg.DBPassword, cfg.DBName, cfg.DBPort, cfg.SSLMode)
   var err error
   DB, err = gorm.Open(postgres.Open(dsn))
   if err != nil {
       log.Fatal("Failed to connect to database")
   }
   fmt.Println("Connected to database successfully")
>>>>>>> Stashed changes
}


