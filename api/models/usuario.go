package models

type Usuario struct {
	Id             int    `json:"id"`
	Email          string `json:"email"`
	Senha          string `json:"senha"`
	Nickname       string `json:"nickname"`
	DataNascimento string `json:"data_nascimento"`
	IsAdmin        bool   `json:"is_admin"`
}
