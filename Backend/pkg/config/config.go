package config

import (
	"log"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

type Config struct {
	DBHost     string
	DBPort     string
	DBUser     string
	DBPassword string
	DBName     string
	SSLMode    string
	AppPort    string
	JWTSecret  string
	DB_URL     string
	API_URL    string
	SMTP_HOST  string
	SMTP_PORT  int
	EMAIL_FROM  string
	EMAIL_PASSWORD string
}

func LoadConfig() Config {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file", err.Error())
	}
	smtpPort, err := strconv.Atoi(os.Getenv("SMTP_PORT"))
	if err != nil {
		log.Fatal("Error converting SMTP_PORT to int", err.Error())
	}

	return Config{
		DBHost:     os.Getenv("DB_HOST"),
		DBPort:     os.Getenv("DB_PORT"),
		DBUser:     os.Getenv("DB_USER"),
		DBPassword: os.Getenv("DB_PASSWORD"),
		DBName:     os.Getenv("DB_NAME"),
		SSLMode:    os.Getenv("SSL_MODE"),
		AppPort:    os.Getenv("APP_PORT"),
		JWTSecret:  os.Getenv("JWT_SECRET"),
		DB_URL:     os.Getenv("DB_URL"),
		API_URL:    os.Getenv("API_URL"),
		SMTP_HOST:  os.Getenv("SMTP_HOST"),
		SMTP_PORT:  smtpPort,
		EMAIL_FROM: os.Getenv("EMAIL_FROM"),
		EMAIL_PASSWORD: os.Getenv("EMAIL_PASSWORD"),
	}

}
