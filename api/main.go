package main

import (
	"api/config"
	"api/db"
	"api/migrations"
	"api/routes"
)

func main() {
	config.LoadEnv()

	db := db.ConnectToDatabase()

	migrations.RunMigrations(db)

	routes.Run()
}
