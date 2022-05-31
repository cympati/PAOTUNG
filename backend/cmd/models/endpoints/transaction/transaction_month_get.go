package transaction

import (
	"fmt"
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

	var transactionMonth []*transaction.TransactionList
	// * Query transaction_info --> use date to check TodayList is exist or not, and query category_info
	result := database.Gorm.Table("transactions").
		Select("transactions.name as transaction_name, transactions.date, transactions.amount, transactions.category_id as category_id, categories.name as category_name, categories.color as category_color").
		//Where("transactions.owner_id = ? AND ((transactions.date <= ? AND transactions.date > ?) OR DATE(transactions.date) = DATE(?) OR DAY(transactions.date) = ?) AND MONTH(transactions.date) = ?", claims.UserId, time.Now(), time.Now().AddDate(0, -1, 0), time.Now(), 1, time.Now().Month()).
		Where("transactions.owner_id = ? AND YEAR(transactions.date) = ? AND MONTH(transactions.date) = ? ", claims.UserId, time.Now().Year(), time.Now().Month()).
		Joins("left join categories on categories.id = transactions.category_id").
		Order("transactions.date desc").
		Scan(&transactionMonth)
	if result.Error != nil {
		return &common.GenericError{
			Message: "Error querying transaction and category information",
			Err:     result.Error,
			Code:    "INVALID_INFORMATION",
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
		var tempString = strings.Split(val.Date.Format(time.RFC1123Z), " ")
		formatDate = tempString[0] + " " + tempString[1] + " " + tempString[2] + " " + tempString[3]
		val.DateString = formatDate
	}

	transactionRes := map[string][]*transaction.TransactionListRes{}

	var amountString = ""
	for _, tr := range transactionMonth {
		amountString = fmt.Sprintf("%+.2f", tr.Amount)

		transactionRes[tr.Date.Format("20060102")] = append(transactionRes[tr.Date.Format("20060102")], &transaction.TransactionListRes{
			Amount:          amountString,
			TransactionName: tr.TransactionName,
			Date:            tr.DateString,
			CategoryName:    tr.CategoryName,
			CategoryColor:   tr.CategoryColor,
		})
	}

	return c.JSON(common.NewInfoResponse(transactionRes, ""))
}
