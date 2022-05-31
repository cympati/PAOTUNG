package account

import (
	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/account"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"

	"time"
)

func Login(c *fiber.Ctx) error {
	body := new(account.LoginRequest)
	if err := c.BodyParser(&body); err != nil { // Get req form client side
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Check user existence
	var user *models.User
	if result := database.Gorm.First(&user, "email = ?", body.Email); result.Error != nil {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "Your account does not exist",
			Err:     result.Error,
		}
	} else if result.RowsAffected == 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "User does not exist",
			Err:     result.Error,
		}
	}

	// * Check user password
	if result := database.Gorm.First(&user, "password = ?", body.Password); result.Error != nil {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "Your password is incorrect",
			Err:     result.Error,
		}
	} else if result.RowsAffected == 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "User does not exist",
			Err:     result.Error,
		}
	}

	spew.Dump(user.Id)

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

		return c.JSON(account.Response{
			Success: true,
			Token:   token, // Jwt token
			Message: "Your login successful",
		})
	}
}
