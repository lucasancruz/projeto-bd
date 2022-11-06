package models

type Manga struct {
	Id              int    `json:"id"`
	Titulo          string `json:"titulo"`
	Sinopse         string `json:"sinopse"`
	Imagem          string `json:"imagem"`
	DataCriacao     string `json:"data_criacao"`
	DataFinalizacao string `json:"data_finalizacao"`
	EditoraId       int    `json:"editora_id"`
}
