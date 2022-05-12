package category

import (
	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/category"
	"paotung-backend/pkg/database"
)

func GetExpenseHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Select top 4 category of expense
	var categoryList []*category.CategoryList
	totalEachCategoryResult := database.Gorm.Limit(4).Table("transactions").
		Select("sum(transactions.amount) as amount, transactions.category_id as category_id, categories.name as category_name, categories.color as category_color").
		Where("transactions.owner_id = ? AND transactions.transaction_type = ?", claims.UserId, "expense").
		Group("category_id").
		Joins("left join categories on categories.id = transactions.category_id").
		Order("amount desc").Scan(&categoryList)
	if totalEachCategoryResult.Error != nil {
		return &common.GenericError{
			Message: "Error querying total amount of each category",
			Err:     totalEachCategoryResult.Error,
		}
	}

	for _, cate := range categoryList {
		if cate.CategoryId == 0 {
			cate.CategoryName = "Uncategorized"
			cate.CategoryColor = 1461410152
		}
	}

	spew.Dump(categoryList)

	// * Cal total
	var total = 0.0
	totalResult := database.Gorm.Table("transactions").Select("sum(amount) as total").Where("owner_id = ? AND transaction_type = ?", claims.UserId, "expense").Scan(&total)

	if totalResult.Error != nil {
		return &common.GenericError{
			Message: "Error querying total amount of expense",
			Err:     totalResult.Error,
		}
	}

	// * Cal each category percent
	var sumPercent = 100.0
	for _, c := range categoryList {
		c.Percent = CalPercent(c.Amount, total)
		sumPercent = sumPercent - c.Percent
	}

	// * Add other info
	categoryList = append(categoryList, &category.CategoryList{
		CategoryId:    999999,
		Amount:        0,
		CategoryName:  "Other",
		CategoryColor: 1461410152,
		Percent:       sumPercent,
	})

	return c.JSON(common.NewInfoResponse(categoryList, ""))
}
