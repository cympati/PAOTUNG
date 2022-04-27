package profile

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/dto/profile"
	"regexp"

	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
)

func PatchHandler(c *fiber.Ctx) error {
	body := new(profile.InfoRequest)
	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Validate email
	var emailRegex = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
	if !emailRegex.Match([]byte(body.Email)) {
		return &common.GenericError{
			Message: "Malformed email address, please type a correct email.",
		}
	}

	var user *models.User

	// * Check email already exist
	if result := database.Gorm.First(&user, "email = ?", body.Email); result.RowsAffected > 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "This email has already used",
		}
	}

	// * Check username already exist
	if result := database.Gorm.First(&user, "user_name = ?", body.UserName); result.RowsAffected > 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "This username has already used",
		}
	}

	// * Update user info
	if result := database.Gorm.First(&user, "id = ?", claims.UserId).
		Updates(
			models.User{
				Email:    &body.Email,
				UserName: &body.UserName,
				Password: &body.Password,
			}); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to update user information",
		}
	}

	return c.JSON(common.InfoResponse{
		Success: true,
		Info:    "Profile information updated successfully",
	})
}
