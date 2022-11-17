package controllers

import (
	"api/db"
	"api/models"
	"api/validators"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func CreateManga(c *gin.Context) {
	var body validators.CreateManga
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
			"error":   err.Error(),
		})
		return
	}

	result := db.DB.Create(&models.Manga{
		Titulo:          body.Titulo,
		Sinopse:         body.Sinopse,
		Imagem:          body.Imagem,
		DataCriacao:     body.DataCriacao,
		DataFinalizacao: body.DataFinalizacao,
		EditoraID:       body.EditoraID,
	})

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"success": true,
		"message": "Mangá cadastrado!",
	})
}

func FindMangaById(c *gin.Context) {
	id := c.Param("id")

	var manga models.Manga
	result := db.DB.First(&manga, id)

	if result.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"success": false,
			"error":   "Mangá não encontrado!",
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"data":    manga,
	})
}

func FindAllManga(c *gin.Context) {
	var mangas []models.Manga

	result := db.DB.Joins("Editora").Find(&mangas)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"data":    mangas,
	})
}

func UpdateManga(c *gin.Context) {
	var manga models.Manga
	var result *gorm.DB

	id := c.Param("id")
	result = db.DB.First(&manga, id)

	if result.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"success": false,
			"error":   "Mangá não encontrado!",
		})
		return
	}

	updatedManga := models.Manga{}

	if err := c.ShouldBind(&updatedManga); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
		})
		return
	}

	result = db.DB.Model(&manga).Updates(&updatedManga)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Mangá atualizado!",
	})
}
