package database
import (
   "fmt"
   "gorm.io/driver/postgres"
   "gorm.io/gorm"
   "A2SVHUB/pkg/config"
   "log"
)
var DB *gorm.DB
func ConnectDB() {
   cfg := config.LoadConfig()
ECHO is off.
   dsn := fmt.Sprintf("host=s password=s port=s",
       cfg.DBHost, cfg.DBUser, cfg.DBPassword, cfg.DBName, cfg.DBPort, cfg.SSLMode)
ECHO is off.
   var err error
   DB, err = gorm.Open(postgres.Open(dsn), 
   if err != nil {
       log.Fatal("Failed to connect to database")
   }
ECHO is off.
   fmt.Println("Connected to database successfully")
}
