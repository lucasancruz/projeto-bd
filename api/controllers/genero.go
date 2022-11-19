package controllers

import (
	"api/db"
	"api/models"
	"api/validators"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func CreateGenero(c *gin.Context) {
	var body validators.CreateGenero
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
			"error":   err.Error(),
		})
		return
	}

	result := db.DB.Create(&models.Genero{Nome: body.Nome})

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"success": true,
		"message": "Gênero cadastrado!",
	})
}

func FindAllGeneros(c *gin.Context) {
	var generos []models.Genero

	result := db.DB.Find(&generos)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"data":    generos,
	})
}

func DeleteGenero(c *gin.Context) {
	var result *gorm.DB

	id := c.Param("id")
	result = db.DB.Delete(&models.Genero{}, id)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Gênero deletado com sucesso!",
	})
}
