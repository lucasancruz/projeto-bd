package models

type Capitulo struct {
	Id             int    `json:"id"`
	MangaId        int    `json:"manga_id"`
	Titulo         string `json:"titulo"`
	Numero         int    `json:"numero"`
	Url            string `json:"url"`
	DataPublicacao string `json:"data_publicacao"`
}
