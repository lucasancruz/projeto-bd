package validators

import "time"

type CreateManga struct {
	Titulo          string    `binding:"required" json:"titulo"`
	Sinopse         string    `binding:"required" json:"sinopse"`
	Imagem          string    `binding:"required" json:"imagem"`
	DataCriacao     time.Time `json:"data_criacao"`
	DataFinalizacao time.Time `json:"data_finalizacao"`
	EditoraID       uint      `binding:"required" json:"editora_id"`
}
