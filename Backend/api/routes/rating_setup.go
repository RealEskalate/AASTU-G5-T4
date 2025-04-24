package routes

// import (
// 	"A2SVHUB/api/controllers"
// 	"A2SVHUB/internal/repositories"
// 	"A2SVHUB/internal/usecases"
// 	"A2SVHUB/pkg/config"

// 	"github.com/gin-gonic/gin"
// 	"gorm.io/gorm"
// )

// func SetupRatingGroup(api *gin.RouterGroup, cfg *config.Config, db *gorm.DB) {

// 	ratingRepo := repositories.NewRatingRepository(db)

// 	ratingUseCase := usecases.NewRatingUseCase(ratingRepo)

// 	ratingController := controllers.NewRatingController(ratingUseCase)

// 	api.GET("/contest/:contest_id", ratingController.GetAllRatings)
// 	api.GET("/:id", ratingController.GetRatingByID)
// 	api.GET("/:id", ratingController.GetRatingByID)
// }
