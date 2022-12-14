package routes

import "github.com/gin-gonic/gin"

var router = gin.Default()

func Run() {
	getRoutes()
	router.Run()
}

func getRoutes() {
	v1 := router.Group("/v1")
	addMangaRoutes(v1)
	addEditoraRoutes(v1)
	addGeneroRoutes(v1)
	addAutorRoutes(v1)
}
