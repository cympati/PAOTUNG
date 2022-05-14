package category

import (
	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/category"
	"paotung-backend/pkg/database"
)

func GetIncomeHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Select top 4 category of income
	var categoryList []*category.CategoryList
	categoryListResult := database.Gorm.Limit(4).Table("transactions").
		Select("sum(transactions.amount) as amount, transactions.category_id as category_id, categories.name as category_name, categories.color as category_color").
		Where("transactions.owner_id = ? AND transactions.transaction_type = ?", claims.UserId, "income").
		Group("category_id").
		Joins("left join categories on categories.id = transactions.category_id").
		Order("amount desc").Scan(&categoryList)
	//fmt.Println(categoryList)
	if categoryListResult.Error != nil {
		return &common.GenericError{
			Message: "Error querying total amount of each category",
			Err:     categoryListResult.Error,
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
	totalResult := database.Gorm.Table("transactions").Select("sum(amount) as total").Where("owner_id = ? AND transaction_type = ?", claims.UserId, "income").Scan(&total)
	if totalResult.Error != nil {
		return &common.GenericError{
			Message: "Error querying total amount of income",
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
	if len(categoryList) >= 4 {
		categoryList = append(categoryList, &category.CategoryList{
			CategoryId:    999999,
			Amount:        0,
			CategoryName:  "Other",
			CategoryColor: 1461410152,
			Percent:       sumPercent,
		})
	}
	return c.JSON(common.NewInfoResponse(categoryList, ""))
}
