package routes

import (
	"api/controllers"

	"github.com/gin-gonic/gin"
)

func addMangaRoutes(rg *gin.RouterGroup) {
	manga := rg.Group("/manga")

	manga.POST("/", controllers.CreateManga)
	manga.GET("/", controllers.FindAllMangas)
	manga.PUT("/:id", controllers.UpdateManga)
	manga.GET("/:id", controllers.FindMangaById)
	manga.DELETE("/:id", controllers.DeleteManga)
}
