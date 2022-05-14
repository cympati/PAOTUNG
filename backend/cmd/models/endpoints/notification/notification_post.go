package notification

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/notification"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
)

func PostHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Parse body
	body := new(notification.NotificationRequest)
	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err,
			Code:    "INVALID_INFORMATION",
		}
	}

	// * Change dateTime Format

	// * Create category record
	notification := &models.Notification{
		Name:     &body.Name,
		DateTime: &body.DateTime,
		OwnerId:  claims.UserId,
	}

	if result := database.Gorm.Create(&notification); result.Error != nil {
		return &common.GenericError{
			Message: "Error create a notification record",
			Err:     result.Error,
			Code:    "INVALID_INFORMATION",
		}
	}

	return c.JSON(&common.InfoResponse{
		Success: true,
		Message: "A notification has been added to system",
		Data: map[string]any{
			"notification_id": &notification.Id,
		},
	})
}
