package fiber

import (
	"log"
	"time"

	"github.com/gofiber/fiber/v2"

	// "paotung-backend/cmd/models/endpoints"
	// "paotung-backend/pkg/fiber/middlewares"

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
			Info:    "KONLAYUTH_HOMEPAGE_API_ROOT",
		})
	})

	// Register API endpoints
	// apiGroup := app.Group("api/")

	// apiGroup.Use(middlewares.Limiter)
	// apiGroup.Use(middlewares.Cors)
	// apiGroup.Use(middlewares.Recover)

	// endpoints.Init(apiGroup)

	// Register not found handler
	app.Use(notfoundHandler)

	// Startup
	err := app.Listen(configs.C.Address)
	if err != nil {
		println("UNABLE TO MIGRATE GORM MODEL")
		log.Fatalf("error: %s", err.Error())
	}
}
