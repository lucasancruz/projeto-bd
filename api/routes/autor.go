package routes

import (
	"api/controllers"

	"github.com/gin-gonic/gin"
)

func addAutorRoutes(rg *gin.RouterGroup) {
	autor := rg.Group("/autor")

	autor.POST("/", controllers.CreateAutor)
	autor.GET("/", controllers.FindAllAutores)
	autor.PUT("/:id", controllers.UpdateAutor)
	autor.DELETE("/:id", controllers.DeleteAutor)
}
