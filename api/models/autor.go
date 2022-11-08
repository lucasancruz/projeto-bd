package models

type Autor struct {
	ID             uint   `gorm:"primaryKey" json:"id"`
	PrimeiroNome   string `gorm:"type:varchar(45);not null" json:"primeiro_nome"`
	Sobrenome      string `gorm:"type:varchar(45);not null" json:"sobrenome"`
	Sobre          string `gorm:"type:text" json:"sobre"`
	Imagem         string `gorm:"type:varchar(150)" json:"imagem"`
	DataNascimento string `gorm:"type:date" json:"data_nascimento"`
}

func (Autor) TableName() string {
	return "autores"
}
