package profile

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/profile"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
	"paotung-backend/pkg/utils/text"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Fetch the user info
	var user *models.User
	if result := database.Gorm.First(&user, claims.UserId); result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "User does not exist",
			Code:    "INVALID_INFORMATION",
			Err:     result.Error,
		}
	}

	return c.JSON(common.NewInfoResponse(&profile.Profile{
		Email:              *user.Email,
		UserName:           *user.UserName,
		PathProfilePicture: text.NilFallback(user.PathProfilePicture),
		Balance:            *user.Balance,
	}, ""))
}
