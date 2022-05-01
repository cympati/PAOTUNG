package database

import (
	"paotung-backend/pkg/database/models"

	"log"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"

	"paotung-backend/pkg/utils/configs"
)

var Gorm *gorm.DB

func Init() {
	// Open SQL connection
	dialector := mysql.New(
		mysql.Config{
			DSN:               configs.C.MySqlDsn,
			DefaultStringSize: 255,
		},
	)

	if db, err := gorm.Open(dialector, &gorm.Config{}); err != nil {
		println("UNABLE TO LOAD GORM MYSQL DATABASE")
		log.Fatalf("error: %s", err.Error())
	} else {
		Gorm = db
	}

	// Initialize model migrations
	if err := migrate(); err != nil {
		println("UNABLE TO MIGRATE GORM MODEL")
		log.Fatalf("error: %s", err.Error())
	}
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
