package category

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/category"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
)

func PostHandler(c *fiber.Ctx) error {
	// * Parse user JWT cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Parse body
	body := new(category.CategoryRequest)
	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Create category record
	category := &models.Category{
		Name:            &body.Name,
		TransactionType: (*models.TransactionType)(&body.TransactionType),
		Color:           &body.Color,
		OwnerId:         claims.UserId,
	}

	if result := database.Gorm.Create(&category); result.Error != nil {
		return &common.GenericError{
			Message: "Error create a category record",
			Err:     result.Error,
		}
	}

	return c.JSON(&common.InfoResponse{
		Success: true,
		Message: "A category has been added to system",
		Data: map[string]any{
			"category_id": &category.Id,
		},
	})
}
