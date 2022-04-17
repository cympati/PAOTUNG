package models

type Category struct {
	Id              *uint64          `gorm:"primaryKey"`
	Name            *string          `gorm:"type:VARCHAR(255); not null"`
	TransactionType *TransactionType `gorm:"type:ENUM('income', 'expense'); not null"`
	Color           *string          `gorm:"type:VARCHAR(255); not null"`
	UserId          *uint64          `gorm:"not null"`
	User            *User            `gorm:"foreignKey:UserId"`
}
