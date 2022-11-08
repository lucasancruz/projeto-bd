package migrations

import (
	"api/models"

	"gorm.io/gorm"
)

func RunMigrations(db *gorm.DB) {
	db.AutoMigrate(&models.Manga{})
	db.AutoMigrate(&models.Editora{})
	db.AutoMigrate(&models.Genero{})
	db.AutoMigrate(&models.Autor{})
	db.AutoMigrate(&models.Capitulo{})
	db.AutoMigrate(&models.Usuario{})
	db.AutoMigrate(&models.Telefone{})
}
