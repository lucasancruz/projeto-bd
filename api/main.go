package main

import (
	"api/config"
	"api/controllers"
	"api/db"
	"api/migrations"

	"github.com/gin-gonic/gin"
)

func main() {
	config.LoadEnv()

	db := db.ConnectToDatabase()

	migrations.RunMigrations(db)

	r := gin.Default()
	r.POST("/manga", controllers.CreateManga)
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
