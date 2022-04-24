package account

import (
	"github.com/gofiber/fiber/v2"
	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"

	"time"
)

func Login(c *fiber.Ctx) error {
	body := new(request)
	if err := c.BodyParser(&body); err != nil { // Get req form client side
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Check user existence
	var user *models.User
	if result := database.Gorm.First(&user, "user_name = ?", body.Username); result.Error != nil {
		return &common.GenericError{
			Message: "Your account, " + body.Username + ", does not exist.",
		}
	} else if result.RowsAffected == 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "User does not exist",
		}
	}

	// * Check user password
	if result := database.Gorm.First(&user, "password = ?", body.Password); result.Error != nil {
		return &common.GenericError{
			Message: "Your password is incorrect.",
		}
	} else if result.RowsAffected == 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "User does not exist",
		}
	}

	// * Generate jwt token
	if token, err := common.SignJwt(
		&common.UserClaim{
			UserId: user.Id,
		},
	); err != nil {
		return err
	} else {
		c.Cookie(&fiber.Cookie{
			Name:    "user",
			Value:   token,
			Expires: time.Now().Add(168 * time.Hour), // 168 hours = 7 days (× 24)
		})

		return c.JSON(response{
			Success: true,
			IsLogin: true,
			Token:   token, // Jwt token
		})
	}
}
