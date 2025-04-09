package routes

import (
	"A2SVHUB/api/controllers"

	"github.com/gin-gonic/gin"
)

func SetupProblemGroup(api *gin.RouterGroup) {
	problem := api.Group("/problem")
	problem.GET("", controllers.GetProblem)
}
