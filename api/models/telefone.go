package models

type Telefone struct {
	UsuarioID uint    `gorm:"not null" json:"usuario_id"`
	Usuario   Usuario `json:"usuario"`
	Telefone  string  `gorm:"type:varchar(11);not null" json:"telefone"`
}
