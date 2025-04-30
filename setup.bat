@echo off
:: Create Go Project Structure for A2SV_HUB with Gin, Gorm, and Neon Postgres
:: Creates directories and initializes basic configuration

set PROJECT_NAME=A2SVHUB

:: Create root folder
mkdir %PROJECT_NAME%
cd %PROJECT_NAME%

:: Create main folders
mkdir cmd
mkdir internal
mkdir internal\domain
mkdir internal\usecases
mkdir internal\repositories
mkdir api
mkdir api\controllers
mkdir api\routes
mkdir pkg
mkdir pkg\config
mkdir pkg\database
mkdir pkg\middleware
mkdir storage
mkdir storage\migrations
mkdir docs
mkdir scripts

:: Initialize Go module
echo Initializing Go module...
go mod init %PROJECT_NAME%

:: Install dependencies
echo Installing dependencies...
go get -u github.com/gin-gonic/gin
go get -u gorm.io/gorm
go get -u gorm.io/driver/postgres
go get -u github.com/joho/godotenv
go get -u github.com/lib/pq

:: Create env file
echo Creating .env file...
(
echo DB_HOST=localhost
echo DB_PORT=5432
echo DB_USER=postgres
echo DB_PASSWORD=postgres
echo DB_NAME=a2sv_hub
echo SSL_MODE=disable
echo APP_PORT=:8080
echo JWT_SECRET=your_jwt_secret_here
) > .env

:: Create config file
echo Creating config file...
(
echo package config

echo import ^(
echo    "github.com/joho/godotenv"
echo    "log"
echo    "os"
echo ^)

echo type Config struct ^{
echo    DBHost     string
echo    DBPort     string
echo    DBUser     string
echo    DBPassword string
echo    DBName     string
echo    SSLMode    string
echo    AppPort    string
echo    JWTSecret  string
echo ^}

echo func LoadConfig^(^) Config ^{
echo    err := godotenv.Load^(^)
echo    if err != nil ^{
echo        log.Fatal^("Error loading .env file"^)
echo    ^}
echo
echo    return Config ^{
echo        DBHost:     os.Getenv^("DB_HOST"^),
echo        DBPort:     os.Getenv^("DB_PORT"^),
echo        DBUser:     os.Getenv^("DB_USER"^),
echo        DBPassword: os.Getenv^("DB_PASSWORD"^),
echo        DBName:     os.Getenv^("DB_NAME"^),
echo        SSLMode:    os.Getenv^("SSL_MODE"^),
echo        AppPort:    os.Getenv^("APP_PORT"^),
echo        JWTSecret:  os.Getenv^("JWT_SECRET"^),
echo    ^}
echo ^}
) > pkg\config\config.go

:: Create database connection file
echo Creating database connection file...
(
echo package database

echo import ^(
echo    "fmt"
echo    "gorm.io/driver/postgres"
echo    "gorm.io/gorm"
echo    "%PROJECT_NAME%/pkg/config"
echo    "log"
echo ^)

echo var DB *gorm.DB

echo func ConnectDB^(^) ^{
echo    cfg := config.LoadConfig^(^)
echo    
echo    dsn := fmt.Sprintf^("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s",
echo        cfg.DBHost, cfg.DBUser, cfg.DBPassword, cfg.DBName, cfg.DBPort, cfg.SSLMode^)
echo    
echo    var err error
echo    DB, err = gorm.Open^(postgres.Open^(dsn^), &gorm.Config^{}^)
echo    if err != nil ^{
echo        log.Fatal^("Failed to connect to database"^)
echo    ^}
echo    
echo    fmt.Println^("Connected to database successfully"^)
echo ^}
) > pkg\database\database.go

:: Create main.go file
echo Creating main.go file...
(
echo package main

echo import ^(
echo    "%PROJECT_NAME%/pkg/config"
echo    "%PROJECT_NAME%/pkg/database"
echo    "%PROJECT_NAME%/api/routes"
echo    "github.com/gin-gonic/gin"
echo ^)

echo func main() ^{
echo    // Load configuration
echo    config.LoadConfig()
echo    
echo    // Initialize database
echo    database.ConnectDB()
echo    
echo    // Setup Gin router
echo    r := gin.Default()
echo    
echo    // Setup routes
echo    routes.SetupRoutes(r)
echo    
echo    // Run server
echo    r.Run(config.LoadConfig().AppPort)
echo ^}
) > cmd\main.go

:: Create basic routes file
echo Creating routes file...
(
echo package routes

echo import (
echo    "github.com/gin-gonic/gin"
echo )

echo func SetupRoutes(r *gin.Engine) {
echo    api := r.Group("/api")
echo    {
echo        // Add your routes here
echo        api.GET("/health", func(c *gin.Context) {
echo            c.JSON(200, gin.H{
echo                "status": "OK",
echo            })
echo        })
echo    }
echo }
) > api\routes\routes.go

echo Project %PROJECT_NAME% has been successfully created!
echo.
echo Next steps:
echo 1. Configure your database connection in .env
echo 2. Run 'go mod tidy' to sync dependencies
echo 3. Run 'go run cmd/main.go' to start the server
pause