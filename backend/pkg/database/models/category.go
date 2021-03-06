package models

type Category struct {
	Id              *uint64          `gorm:"primaryKey"`
	Name            *string          `gorm:"type:VARCHAR(255); not null"`
	TransactionType *TransactionType `gorm:"type:ENUM('income', 'expense'); not null"`
	Color           *uint64          `gorm:"not null"`
	OwnerId         *uint64          `gorm:"not null"`
	Owner           *User            `gorm:"foreignKey:OwnerId"`
}
