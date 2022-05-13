package transaction

import (
	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/transaction"
	"paotung-backend/pkg/database"
	"strings"
	"time"
)

func GetMonthHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	//spew.Dump("dasdsdsads")
	var transactionMonth []*transaction.TransactionList
	// * Query transaction_info --> use date to check TodayList is exist or not, and query category_info
	result := database.Gorm.Table("transactions").
		Select("transactions.name as transaction_name, transactions.date, transactions.amount, transactions.category_id as category_id, categories.name as category_name, categories.color as category_color").
		Where("transactions.owner_id = ? AND transactions.date <= ? AND transactions.date > ?", claims.UserId, time.Now(), time.Now().AddDate(0, -1, 0)).
		Joins("left join categories on categories.id = transactions.category_id").
		Order("date desc").Scan(&transactionMonth)
	if result.Error != nil || result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "Error querying transaction and category information",
			Err:     result.Error,
		}
	}

	// * Check if category is null --> change color and category_name to empty string
	for _, trans := range transactionMonth {
		if trans.CategoryId == 0 {
			trans.CategoryName = "Uncategorized"
			trans.CategoryColor = 1461410152
		}
	}

	var formatDate = ""

	for _, val := range transactionMonth {
		spew.Dump(val.Date)
		var tempString = strings.Split(val.Date.Format(time.RFC1123Z), " ")
		formatDate = tempString[0] + " " + tempString[1] + " " + tempString[2] + " " + tempString[3]
		spew.Dump(formatDate) // Tue, 12 Feb 2022
		val.DateString = formatDate
		spew.Dump(val.DateString)
	}

	transactionRes := map[string][]*transaction.TransactionList{}

	for _, tr := range transactionMonth {
		transactionRes[tr.DateString] = append(transactionRes[tr.DateString], &transaction.TransactionList{
			Amount:          tr.Amount,
			TransactionName: tr.TransactionName,
			Date:            tr.Date,
			DateString:      tr.DateString,
			CategoryId:      tr.CategoryId,
			CategoryName:    tr.CategoryName,
			CategoryColor:   tr.CategoryColor,
		})
	}

	return c.JSON(common.NewInfoResponse(transactionRes, ""))
}
