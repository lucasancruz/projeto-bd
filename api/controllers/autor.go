package controllers

import (
	"api/db"
	"api/models"
	"api/validators"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func CreateAutor(c *gin.Context) {
	var body validators.CreateAutor
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
			"error":   err.Error(),
		})
		return
	}

	result := db.DB.Create(&models.Autor{
		PrimeiroNome:   body.PrimeiroNome,
		Sobrenome:      body.Sobrenome,
		Sobre:          body.Sobre,
		Imagem:         body.Imagem,
		DataNascimento: body.DataNascimento,
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
		"message": "Autor cadastrado!",
	})
}

func FindAllAutores(c *gin.Context) {
	var autores []models.Manga

	result := db.DB.Find(&autores)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"data":    autores,
	})
}

func UpdateAutor(c *gin.Context) {
	var result *gorm.DB

	id, _ := strconv.Atoi(c.Param("id"))
	autor := models.Manga{ID: uint(id)}

	updatedAutor := models.Autor{}
	if err := c.ShouldBind(&updatedAutor); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
		})
		return
	}

	result = db.DB.Model(&autor).Updates(&updatedAutor)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Autor atualizado!",
	})
}

func DeleteAutor(c *gin.Context) {
	var result *gorm.DB

	id := c.Param("id")
	result = db.DB.Delete(&models.Autor{}, id)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Autor deletado com sucesso!",
	})
}
