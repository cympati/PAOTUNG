package middlewares

import (
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"

	"paotung-backend/pkg/utils/configs"
)

var Cors = func() fiber.Handler {
	// origins is the value of allowed CORS addresses, separated by comma (,).
	// Example: "https://www.google.com, http://localhost:8080"
	origins := ""
	for i, s := range configs.C.Cors {
		origins += s
		if i < len(configs.C.Cors)-1 {
			origins += ", "
		}
	}

	conf := cors.Config{
		AllowOrigins:     origins,
		AllowCredentials: true,
	}

	return cors.New(conf)
}()
