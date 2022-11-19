package routes

import (
	"api/controllers"

	"github.com/gin-gonic/gin"
)

func addGeneroRoutes(rg *gin.RouterGroup) {
	genero := rg.Group("/genero")

	genero.POST("/", controllers.CreateGenero)
	genero.GET("/", controllers.FindAllGeneros)
	genero.DELETE("/:id", controllers.DeleteGenero)
}
