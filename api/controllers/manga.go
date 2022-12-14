package controllers

import (
	"api/db"
	"api/models"
	"api/validators"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
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
	result := db.DB.Preload(clause.Associations).First(&manga, id)

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

func FindAllMangas(c *gin.Context) {
	var mangas []models.Manga

	result := db.DB.Find(&mangas)

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
	var result *gorm.DB

	id, _ := strconv.Atoi(c.Param("id"))
	manga := models.Manga{ID: uint(id)}

	updatedManga := models.Manga{}
	if err := c.ShouldBind(&updatedManga); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
			"error":   err.Error(),
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

func DeleteManga(c *gin.Context) {
	var result *gorm.DB

	id := c.Param("id")
	result = db.DB.Delete(&models.Manga{}, id)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Mangá deletado com sucesso!",
	})
}

func AddChapter(c *gin.Context) {
	var capitulo models.Capitulo
	if err := c.ShouldBindJSON(&capitulo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
			"error":   err.Error(),
		})
		return
	}

	id, _ := strconv.Atoi(c.Param("id"))
	capitulo.MangaID = uint(id)

	result := db.DB.Create(&capitulo)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Capítulo cadastrado com sucesso!",
	})
}
