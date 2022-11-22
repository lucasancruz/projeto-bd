package models

import (
	"time"
)

type Manga struct {
	ID              uint       `gorm:"primaryKey" json:"id"`
	Titulo          string     `gorm:"type:varchar(120);not null" json:"titulo"`
	Sinopse         string     `gorm:"type:text;not null" json:"sinopse"`
	Imagem          string     `gorm:"type:varchar(150);not null" json:"imagem"`
	DataCriacao     *time.Time `gorm:"type:date" json:"data_criacao,omitempty"`
	DataFinalizacao *time.Time `gorm:"type:date" json:"data_finalizacao,omitempty"`
	EditoraID       uint       `gorm:"not null" json:"editora_id"`
	Editora         *Editora   `json:"editora,omitempty"`
	Generos         []Genero   `gorm:"many2many:manga_generos;" json:"generos"`
	Autores         []Autor    `gorm:"many2many:manga_autores;" json:"autores"`
	Capitulos       []Capitulo `json:"capitulos"`
}
