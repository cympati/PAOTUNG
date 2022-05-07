package notification

import (
	"github.com/gofiber/fiber/v2"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	//cookie := c.Locals("user").(*jwt.Token)
	//claims := cookie.Claims.(*common.UserClaim)

	// * Fetch notifications of this user
	return nil
}
