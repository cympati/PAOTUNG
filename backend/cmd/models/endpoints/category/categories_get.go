package category

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	Category "paotung-backend/cmd/models/dto/category"
	"paotung-backend/pkg/database"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Fetch the category info
	var category []*Category.CategoryNameList
	if result := database.Gorm.Table("categories").Select("id", "name").Where("owner_id = ?", claims.UserId).Scan(&category); result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "There is no any category of this account",
		}
	}

	// * Expense list

	// * Income list

	return c.JSON(common.NewInfoResponse(&category, ""))

}
