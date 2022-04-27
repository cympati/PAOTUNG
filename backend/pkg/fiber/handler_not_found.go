package fiber

import (
	"github.com/gofiber/fiber/v2"

	"paotung-backend/cmd/models/common"
)

func notfoundHandler(ctx *fiber.Ctx) error {
	return ctx.Status(fiber.StatusNotFound).JSON(common.ErrorResponse{
		Success: false,
		Error:   "404_NOT_FOUND",
	})
}
