package category

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"gorm.io/gorm"
	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
)

func DeleteAllHandler(c *fiber.Ctx) error {
	// Parse JWT cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Change category_id in all transaction to NULL
	if result := database.Gorm.Model(&models.Transaction{}).Where("owner_id = ?", claims.UserId).
		Update("category_id", gorm.Expr("NULL")); result.Error != nil {
		return &common.GenericError{
			Code:    "BAD_REQUEST",
			Err:     result.Error,
			Message: "Unable to update transaction information",
		}
	}

	// * Remove all categories
	if result := database.Gorm.Delete(&models.Category{}, "owner_id = ?", claims.UserId); result.Error != nil {
		return &common.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "Error deleting all category row",
			Err:     result.Error,
		}
	}

	return c.JSON(common.InfoResponse{
		Success: true,
		Message: "Successfully removed all categories",
	})
}
