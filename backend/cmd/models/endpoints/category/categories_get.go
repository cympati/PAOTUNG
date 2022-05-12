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
	// * Expense list
	var expenseList []*Category.CategoryNameList
	if resultExpense := database.Gorm.Table("categories").
		Select("id", "name", "color").
		Where("owner_id = ? AND transaction_type = 'expense'", claims.UserId).
		Scan(&expenseList); resultExpense.RowsAffected == 0 {
		return &common.GenericError{
			Message: "There is no any category of this account",
			Err:     resultExpense.Error,
		}
	}

	// * Income list
	var incomeList []*Category.CategoryNameList
	if resultIncome := database.Gorm.Table("categories").
		Select("id", "name", "color").
		Where("owner_id = ? AND transaction_type = 'income'", claims.UserId).
		Scan(&incomeList); resultIncome.RowsAffected == 0 {
		return &common.GenericError{
			Message: "There is no any category of this account",
			Err:     resultIncome.Error,
		}
	}

	var category Category.CategoryTypeList = Category.CategoryTypeList{Expense: expenseList,
		Income: incomeList}

	return c.JSON(common.NewInfoResponse(&category, ""))

}
