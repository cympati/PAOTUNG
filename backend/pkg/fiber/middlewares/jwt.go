package middlewares

import (
	"fmt"

	"github.com/gofiber/fiber/v2"
	jwtware "github.com/gofiber/jwt/v3"

	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/utils/configs"
)

var Jwt = func() fiber.Handler {
	conf := jwtware.Config{
		SigningKey:  []byte(configs.C.JwtSecret),
		TokenLookup: "header:Authorization",
        AuthScheme: "Bearer",
        ContextKey:  "user",
		Claims:      &common.UserClaim{},
		ErrorHandler: func(c *fiber.Ctx, err error) error {
			return &common.GenericError{
				Message: "JWT validation failure",
				Err:     err,
			}
		},
	}

	fmt.Sprint(jwtware.New(conf))
	return jwtware.New(conf)
}()
