package notification

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
	"strconv"
)

func DeleteByIdHandler(c *fiber.Ctx) error {
	// * Parse JWT cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Parse parameters
	notificationId, err := strconv.ParseUint(c.Query("notification_id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse query parameter",
			Err:     err,
			Code:    "INVALID_INFORMATION",
		}
	}

	// * Remove category by id
	if result := database.Gorm.Delete(&models.Notification{}, "id = ? AND owner_id = ?", notificationId, claims.UserId); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to delete notification row",
			Err:     result.Error,
			Code:    "INVALID_INFORMATION",
		}
	}

	return c.JSON(common.InfoResponse{
		Success: true,
		Message: "Successfully removed the notification",
	})
}
