package models

import (
	"time"
)

type Transaction struct {
	Id              *uint64          `gorm:"primaryKey"`
	TransactionType *TransactionType `gorm:"type:ENUM('income', 'expense'); not null"`
	Name            *string          `gorm:"type:VARCHAR(255); not null"`
	Date            *time.Time       `gorm:"not null"`
	Amount          *float64         `gorm:"not null"`
	CategoryId      *uint64          `gorm:""`
	Category        *Category        `gorm:"foreignKey:CategoryId"`
	OwnerId         *uint64          `gorm:"not null"`
	Owner           *User            `gorm:"foreignKey:OwnerId"`
}
