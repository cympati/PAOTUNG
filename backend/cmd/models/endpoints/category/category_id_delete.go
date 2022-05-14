package category

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"gorm.io/gorm"
	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
	"strconv"
)

func DeleteByIdHandler(c *fiber.Ctx) error {
	// * Parse JWT cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Parse parameters
	categoryId, err := strconv.ParseUint(c.Query("category_id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse query parameter",
			Err:     err,
			Code:    "INVALID_INFORMATION",
		}
	}

	// * Change category_id in transaction to NULL
	if result := database.Gorm.Model(&models.Transaction{}).Where("owner_id = ? AND category_id = ?", claims.UserId, categoryId).
		Update("category_id", gorm.Expr("NULL")); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to update transaction information",
			Code:    "INVALID_INFORMATION",
			Err:     result.Error,
		}
	}

	// * Remove category by id
	if result := database.Gorm.Delete(&models.Category{}, "id = ? AND owner_id = ?", categoryId, claims.UserId); result.Error != nil {
		return &common.GenericError{
			Message: "Error deleting category row",
			Err:     result.Error,
			Code:    "INVALID_INFORMATION",
		}
	}

	return c.JSON(common.InfoResponse{
		Success: true,
		Message: "Successfully removed the category",
	})
}
