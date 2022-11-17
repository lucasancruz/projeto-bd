package routes

import (
	"api/controllers"

	"github.com/gin-gonic/gin"
)

func addMangaRoutes(rg *gin.RouterGroup) {
	manga := rg.Group("/manga")

	manga.POST("/", controllers.CreateManga)
	manga.PUT("/:id", controllers.UpdateManga)
	manga.GET("/:id", controllers.FindMangaById)
	manga.GET("/", controllers.FindAllManga)
}
