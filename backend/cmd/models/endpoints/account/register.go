package account

import (
	"github.com/gofiber/fiber/v2"
	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
	"time"
)

func Register(c *fiber.Ctx) error {
	body := new(registerRequest)
	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Validate new register
	// * Validate password pattern
	// * Validator maybe in frontend
	//password := body.Password
	//if len(password) < 8 || len(password) > 255 || !text.PrintableASCII(password) {
	//	return &common.GenericError{
	//		Code:    "INVALID_INFORMATION",
	//		Message: "Password length must be between 8 to 255 characters",
	//	}
	//}

	// * Check user already exist
	var user *models.User
	if result := database.Gorm.First(&user, "email = ? AND user_name = ?", body.Email, body.Username); result.RowsAffected > 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "This account has already registered",
		}
	}

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
			Token:   token, // Jwt token
			Message: "Your account has been created.",
		})
	}
}
