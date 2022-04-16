// migrate
package database

import (
	"paotung-backend/pkg/database/models"
	// "time"

	// "gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var Gorm *gorm.DB

func Init() {
	migrate()
}

func migrate() error {
	if err := Gorm.AutoMigrate(
		new(models.User),
		new(models.Category),
		new(models.Notification),
		new(models.Transaction),
	); err != nil {
		return err
	}

	return nil
}
