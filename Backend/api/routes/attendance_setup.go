package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"A2SVHUB/pkg/middleware"
	"A2SVHUB/pkg/utils"
	"context"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupAttendanceGroup(attendanceRoute *gin.RouterGroup, db *gorm.DB, tokenService *utils.TokenService) {
	// Initialize Repositories and Usecase
	attendanceRepository := repositories.NewAttendanceRepository(db, context.TODO())
	sessionRepository := repositories.NewSessionRepository(db, context.TODO())
	userRepository := repositories.NewUserRepository(db)
	attendanceUseCase := usecases.NewAttendanceUseCase(attendanceRepository, sessionRepository, userRepository, context.TODO())
	attendanceController := controllers.NewAttendanceController(attendanceUseCase)

	// Setup middleware
	authMiddleware := middleware.AuthMiddleware(tokenService)

	// Authenticated routes
	attendanceRoute.Use(authMiddleware) // <--- attach middleware to all below
	{
		attendanceRoute.GET("", attendanceController.GetAllAttendances)
		attendanceRoute.GET("/:id", attendanceController.GetAttendance)
		attendanceRoute.POST("", attendanceController.TakeAttendance)
		attendanceRoute.POST("/users", attendanceController.TakeMassAttendance)
		attendanceRoute.PUT("/:id", attendanceController.UpdateAttendance)
		attendanceRoute.DELETE("/:id", attendanceController.DeleteAttendance)
	}
}
