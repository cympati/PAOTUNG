package fiber

import (
	"strings"

	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v2"

	"paotung-backend/cmd/models/common"
)

func errorHandler(ctx *fiber.Ctx, err error) error {
	// Case of *fiber.Error.
	if e, ok := err.(*fiber.Error); ok {
		return ctx.Status(e.Code).JSON(common.ErrorResponse{
			Success: false,
			Code:    strings.ReplaceAll(strings.ToUpper(e.Error()), " ", "_"),
			Message: e.Error(),
			Error:   e.Error(),
		})
	}

	if e, ok := err.(*common.GenericError); ok {
		if len(e.Code) == 0 {
			e.Code = "GENERIC_ERROR"
		}

		if e.Err != nil {
			return ctx.Status(fiber.StatusBadRequest).JSON(common.ErrorResponse{
				Success: false,
				Code:    e.Code,
				Message: e.Message,
				Error:   e.Err.Error(),
			})
		}

		return ctx.Status(fiber.StatusBadRequest).JSON(common.ErrorResponse{
			Success: false,
			Code:    e.Code,
			Message: e.Message,
		})
	}

	// Case of validator.ValidationErrors
	if e, ok := err.(validator.ValidationErrors); ok {
		return ctx.Status(fiber.StatusBadRequest).JSON(common.ErrorResponse{
			Success: false,
			Code:    "INVALID_VALIDATION",
			Message: "Invalid request body",
			Error:   e.Error(),
		})
	}

	return ctx.Status(fiber.StatusInternalServerError).JSON(
		common.ErrorResponse{
			Success: false,
			Code:    "UNKNOWN_SERVER_SIDE_ERROR",
			Message: "Unknown server side error",
			Error:   err.Error(),
		},
	)
}
