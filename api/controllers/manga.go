package controllers

import (
	"api/db"
	"api/models"
	"api/validators"
	"net/http"

	"github.com/gin-gonic/gin"
)

func CreateManga(c *gin.Context) {
	var body validators.CreateManga

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	db.DB.Create(&models.Manga{
		Titulo:          body.Titulo,
		Sinopse:         body.Sinopse,
		Imagem:          body.Imagem,
		DataCriacao:     body.DataCriacao,
		DataFinalizacao: body.DataFinalizacao,
		EditoraID:       body.EditoraID,
	})

	c.JSON(http.StatusCreated, gin.H{
		"success": true,
		"message": "Mangá cadastrado!",
	})
}
