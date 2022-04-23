package models

import (
	"time"
)

type Notification struct {
	Id              *uint64          `gorm:"primaryKey"`
	Name            *string          `gorm:"type:VARCHAR(255); not null"`
	TransactionType *TransactionType `gorm:"type:ENUM('income', 'expense'); not null"`
	DateTime        *time.Time       `gorm:"not null"`
	OwnerId         *uint64          `gorm:"not null"`
	Owner           *User            `gorm:"foreignKey:OwnerId"`
}
