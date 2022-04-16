package models

import (
	"time"
)

type User struct {
	Id                 *uint64    `gorm:"primaryKey"`
	Email              *string    `gorm:"type:VARCHAR(255); index:email,unique; not null"`
	Password           *string    `gorm:"type:VARCHAR(255); not null"`
	UserName           *string    `gorm:"type:VARCHAR(255); not null"`
	PhoneNumber        *string    `gorm:"type:VARCHAR(10); not null"`
	BirthDate          *time.Time `gorm:"not null"`
	JoinDate           *time.Time `gorm:"not null"`
	PathProfilePicture *string    `gorm:"type:VARCHAR(255)`
	Balance            *int64     `gorm:"default:0; not null"`
}
