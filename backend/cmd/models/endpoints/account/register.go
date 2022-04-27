package account

import (
	"github.com/gofiber/fiber/v2"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/account"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
	"paotung-backend/pkg/utils/text"
	"regexp"
	"time"
)

func Register(c *fiber.Ctx) error {
	body := new(account.RegisterRequest)
	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Validate new register
	// * Validate password pattern
	password := body.Password
	if len(password) < 8 || len(password) > 255 || !text.PrintableASCII(password) {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "Password length must be between 8 to 255 characters",
		}
	}

	// * Check email already exist
	user := models.User{
		Email:    &body.Email,
		Password: &body.Password,
		UserName: &body.UserName,
	}

	// * Validate email
	var emailRegex = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
	if !emailRegex.Match([]byte(body.Email)) {
		return &common.GenericError{
			Message: "Malformed email address, please type a correct email.",
		}
	}

	if result := database.Gorm.First(&user, "email = ?", body.Email); result.RowsAffected > 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "This account has already registered",
		}
	}

	// * Check username already exist
	if result := database.Gorm.First(&user, "user_name = ?", body.UserName); result.RowsAffected > 0 {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "This username has already registered",
		}
	}

	// Create account record in database
	if result := database.Gorm.Create(&user); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to create database record",
			Err:     result.Error,
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

		return c.JSON(account.Response{
			Success: true,
			Token:   token, // Jwt token
			Message: "Your account has been created.",
		})
	}
}
