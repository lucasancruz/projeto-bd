package models

type Editora struct {
	ID   uint   `gorm:"primaryKey" json:"id"`
	Nome string `gorm:"type:varchar(45);not null" json:"nome"`
}
