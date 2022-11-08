package models

import "time"

type Usuario struct {
	ID             uint      `gorm:"primaryKey" json:"id"`
	Email          string    `gorm:"type:varchar(120);not null" json:"email"`
	Senha          string    `gorm:"type:varchar(12);not null" json:"senha"`
	Nickname       string    `gorm:"type:varchar(45);not null" json:"nickname"`
	DataNascimento time.Time `gorm:"type:date;not null" json:"data_nascimento"`
	IsAdmin        bool      `gorm:"type:bool;not null" json:"is_admin"`
}
