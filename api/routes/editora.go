package routes

import (
	"api/controllers"

	"github.com/gin-gonic/gin"
)

func addEditoraRoutes(rg *gin.RouterGroup) {
	editora := rg.Group("/editora")

	editora.POST("/", controllers.CreateEditora)
	editora.GET("/", controllers.FindAllEditoras)
	editora.PUT("/:id", controllers.UpdateEditora)
	editora.DELETE("/:id", controllers.DeleteEditora)
}
