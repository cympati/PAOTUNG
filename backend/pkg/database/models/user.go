package models

import (
	"time"
)

type User struct {
	Id                 *uint64 `gorm:"primaryKey"`
	Email              *string `gorm:"type:VARCHAR(255); index:email,unique; not null"`
	Password           *string `gorm:"type:VARCHAR(255); not null"`
	UserName           *string `gorm:"type:VARCHAR(255); index:username,unique; not null"`
	CreatedAt          *time.Time
	PathProfilePicture *string `gorm:"type:VARCHAR(255)"`
	Balance            *int64  `gorm:"default:0; not null"`
}
