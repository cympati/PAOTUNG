package models

import (
	"time"
)

type Notification struct {
	Id              *uint64          `gorm:"primaryKey"`
	Name            *string          `gorm:"type:VARCHAR(255); not null"`
	TransactionType *TransactionType `gorm:"type:ENUM('income', 'expense'); default:draft; not null"`
	CategoryId      *uint64          `gorm:not null`
	Category        *Category        `gorm:"foreignKey:CategoryId"`
	DateTime        *time.Time       `gorm:"not null"`
	Frequency       *string          `gorm:"not null"`
	UserId          *uint64          `gorm:"not null"`
	User            *User            `gorm:"foreignKey:UserId"`
}
