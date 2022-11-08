package models

import "time"

type Capitulo struct {
	ID             uint      `gorm:"primaryKey" json:"id"`
	MangaID        uint      `gorm:"not null" json:"manga_id"`
	Manga          Manga     `json:"manga"`
	Titulo         string    `gorm:"type:varchar(45);not null" json:"titulo"`
	Numero         uint32    `gorm:"not null" json:"numero"`
	Url            string    `gorm:"type:varchar(120);not null" json:"url"`
	DataPublicacao time.Time `gorm:"type:datetime;not null" json:"data_publicacao"`
}
