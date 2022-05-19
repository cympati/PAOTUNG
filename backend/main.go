package main

import (
	"os"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/fiber"
)

func main() {
	database.Init()
	fiber.Init()
	os.Setenv("TZ", "Thailand/Bangkok")
}
