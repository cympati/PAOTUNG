package main

import (
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/fiber"
)

func main() {
	database.Init()
	fiber.Init()
}
