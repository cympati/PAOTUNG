package notification

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
)

func DeleteAllHandler(c *fiber.Ctx) error {
	// Parse JWT cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Remove all categories
	if result := database.Gorm.Delete(&models.Notification{}, "owner_id = ?", claims.UserId); result.Error != nil {
		return &common.GenericError{
			Message: "Error deleting all notification row",
			Err:     result.Error,
		}
	}

	return c.JSON(common.InfoResponse{
		Success: true,
		Message: "Successfully removed all notifications",
	})
}
