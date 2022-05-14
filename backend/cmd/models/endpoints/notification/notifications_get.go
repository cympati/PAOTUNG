package notification

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/notification"
	"paotung-backend/pkg/database"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Fetch notifications of this user
	var notificationList []*notification.Notification
	if result := database.Gorm.Table("notifications").
		Select("id", "name", "date_time").
		Where("owner_id = ?", claims.UserId).
		Scan(&notificationList); result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "There is no any notification in your account",
			Err:     result.Error,
		}
	}
	return c.JSON(common.NewInfoResponse(&notificationList, ""))
}
