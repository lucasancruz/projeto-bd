package models

type Autor struct {
	Id             int    `json:"id"`
	PrimeiroNome   string `json:"primeiro_nome"`
	Sobrenome      string `json:"sobrenome"`
	Sobre          string `json:"sobre"`
	Imagem         string `json:"imagem"`
	DataNascimento string `json:"data_nascimento"`
}
