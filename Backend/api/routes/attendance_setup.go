package routes

import (
	"A2SVHUB/api/controllers"
	"A2SVHUB/internal/repositories"
	"A2SVHUB/internal/usecases"
	"context"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SetupAttendanceGroup(attendanceRoute *gin.RouterGroup, db *gorm.DB) {
	attendanceRepository := repositories.NewAttendanceRepository(db, context.TODO())
	sessionRepository := repositories.NewSessionRepository(db, context.TODO())
	userRepository := repositories.NewUserRepository(*db)
	attendanceUseCase := usecases.NewAttendanceUseCase(attendanceRepository, sessionRepository, userRepository, context.TODO())
	attendanceController := controllers.NewAttendanceController(attendanceUseCase)

	attendanceRoute.GET("", attendanceController.GetAllAttendances)
	attendanceRoute.GET("/:id", attendanceController.GetAttendance)
	attendanceRoute.POST("", attendanceController.TakeAttendance)
	attendanceRoute.POST("/users", attendanceController.TakeMassAttendance)
	attendanceRoute.PUT("/:id", attendanceController.UpdateAttendance)
	attendanceRoute.DELETE("/:id", attendanceController.DeleteAttendance)

}