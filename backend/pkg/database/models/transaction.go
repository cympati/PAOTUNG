package models

import (
	"time"
)

type Transaction struct {
	Id              *uint64          `gorm:"primaryKey"`
	TransactionType *TransactionType `gorm:"type:ENUM('income', 'expense'); not null"`
	Name            *string          `gorm:"type:VARCHAR(255); not null"`
	Date            *time.Time       `gorm:"not null"`
	Price           *uint64          `gorm:"not null"`
	CategoryId      *uint64          `gorm:"not null"`
	Category        *Category        `gorm:"foreignKey:CategoryId"`
	UserId          *uint64          `gorm:"not null"`
	User            *User            `gorm:"foreignKey:UserId"`
}
