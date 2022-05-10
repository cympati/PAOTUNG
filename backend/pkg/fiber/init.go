package fiber

import (
	"log"
	"time"

	"github.com/gofiber/fiber/v2"

	"paotung-backend/cmd/controllers"
	"paotung-backend/pkg/fiber/middlewares"

	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/utils/configs"
)

var app *fiber.App

func Init() {
	// Initialize fiber instance
	app = fiber.New(fiber.Config{
		ErrorHandler:  errorHandler,
		Prefork:       false,
		StrictRouting: true,
		ReadTimeout:   5 * time.Second,
		WriteTimeout:  5 * time.Second,
	})

	// Register root endpoint
	app.All("/", func(c *fiber.Ctx) error {
		return c.JSON(common.InfoResponse{
			Success: true,
			Message: "PAOTUNG_API_ROOT",
		})
	})

	// Register API endpoints
	apiGroup := app.Group("api/")
	apiGroup.Use(middlewares.Cors)
	controllers.Init(apiGroup)

	// Register not found handler
	app.Use(notfoundHandler)

	// Startup
	err := app.Listen(configs.C.Address)
	if err != nil {
		println("UNABLE TO MIGRATE GORM MODEL")
		log.Fatalf("error: %s", err.Error())
	}
}
