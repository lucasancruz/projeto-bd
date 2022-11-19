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

func CreateEditora(c *gin.Context) {
	var body validators.CreateEditora
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
			"error":   err.Error(),
		})
		return
	}

	result := db.DB.Create(&models.Editora{Nome: body.Nome})

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"success": true,
		"message": "Editora cadastrada!",
	})
}

func FindAllEditoras(c *gin.Context) {
	var editoras []models.Editora

	result := db.DB.Find(&editoras)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"data":    editoras,
	})
}

func UpdateEditora(c *gin.Context) {
	var result *gorm.DB

	id, _ := strconv.Atoi(c.Param("id"))
	editora := models.Editora{ID: uint(id)}

	updatedEditora := models.Editora{}
	if err := c.ShouldBind(&updatedEditora); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": false,
		})
		return
	}

	result = db.DB.Model(&editora).Updates(&updatedEditora)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Editora atualizada!",
	})
}

func DeleteEditora(c *gin.Context) {
	var result *gorm.DB

	id := c.Param("id")
	result = db.DB.Delete(&models.Editora{}, id)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"success": false,
			"error":   result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"message": "Editora deletada com sucesso!",
	})
}
