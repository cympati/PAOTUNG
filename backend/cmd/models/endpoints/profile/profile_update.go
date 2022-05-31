package profile

import (
	"github.com/davecgh/go-spew/spew"
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
			Code:    "INVALID_INFORMATION",
		}
	}

	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)
	spew.Dump(claims.UserId)
	var passwd = ""
	if pswResult := database.Gorm.Table("users").Select("password").Where("id = ?", claims.UserId).Scan(&passwd); pswResult.Error != nil {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "User account is not exist",
			Err:     pswResult.Error,
		}
	}

	spew.Dump(body.Password)
	spew.Dump(passwd)
	if body.Password != passwd {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "Password is incorrect",
			Err:     fiber.ErrBadRequest,
		}
	}

	// * Validate email
	var emailRegex = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
	if !emailRegex.Match([]byte(body.Email)) {
		return &common.GenericError{
			Message: "Malformed email address, please type a correct email",
			Code:    "INVALID_INFORMATION",
			Err:     fiber.ErrBadRequest,
		}
	}

	var user *models.User

	// * Check email already exist
	if result := database.Gorm.First(&user, "email = ? AND id != ?", body.Email, claims.UserId); result.RowsAffected > 0 {
		if result := database.Gorm.First(&user, "user_name = ? AND id != ?", body.UserName, claims.UserId); result.RowsAffected > 0 {
			spew.Dump(result.Error)
			return &common.GenericError{
				Code:    "INVALID_INFORMATION",
				Message: "This email and username have already used",
				Err:     result.Error,
			}
		}
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "This email has already used",
			Err:     result.Error,
		}
	} else if result.RowsAffected == 0 {
		// * Check username already exist
		if result := database.Gorm.First(&user, "user_name = ? AND id != ?", body.UserName, claims.UserId); result.RowsAffected > 0 {
			return &common.GenericError{
				Code:    "INVALID_INFORMATION",
				Message: "This username has already used",
				Err:     result.Error,
			}
		} else if result.RowsAffected == 0 {
			// * Update user info
			spew.Dump(body.PathProfilePicture)

			if result := database.Gorm.First(&user, "id = ?", claims.UserId).
				Updates(
					models.User{
						Email:              &body.Email,
						UserName:           &body.UserName,
						Password:           &body.Password,
						PathProfilePicture: &body.PathProfilePicture,
					}); result.Error != nil {
				return &common.GenericError{
					Message: "Unable to update user information",
					Code:    "INVALID_INFORMATION",
					Err:     result.Error,
				}
			}
		}
	}

	return c.JSON(common.InfoResponse{
		Success: true,
		Message: "Profile information updated successfully",
	})
}
