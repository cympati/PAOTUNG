package transaction

import (
	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/transaction"
	"paotung-backend/pkg/database"
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

	//spew.Dump(transactionToday)

	// * Check if category is null --> change color and category_name to empty string
	for _, trans := range transactionMonth {
		if trans.CategoryId == 0 {
			trans.CategoryName = "Uncategorized"
			trans.CategoryColor = 1461410152
		}
	}

	// * When return don't forgot to change date to string as 'Tue, 12 Feb 2022'
	// ****** Not finish ******
	const (
		//layoutISO = "2006-01-02"
		layoutUS = "Tue, 12 Feb 2022"
	)
	//for _, val := range *transactionToday {
	//	spew.Dump(val.Date)
	//	dt, _ := time.Parse(layoutISO, val.Date)
	//	spew.Dump(dt) // 1999-12-31 00:00:00 +0000 UTC
	//	formatDate := dt.Format(layoutUS)
	//	spew.Dump(formatDate) // Tue, 12 Feb 2022
	//	val.Date = formatDate
	//}

	// * Test
	var formatDate = ""
	for _, val := range transactionMonth {
		spew.Dump(val.Date)
		dt, _ := time.Parse(time.RFC3339, val.Date.String())
		spew.Dump(dt) // 1999-12-31 00:00:00 +0000 UTC
		formatDate = dt.Format(layoutUS)
		spew.Dump(formatDate) // Tue, 12 Feb 2022
		val.DateString = formatDate
		spew.Dump(val.DateString)
	}

	// * Not finish
	var transactionRes = [100]*transaction.TransactionMonthList{}

	spew.Dump(transactionRes)
	for i, tr1 := range transactionMonth {
		transactionRes[i].Date = tr1.DateString
		spew.Dump(tr1.DateString)
		for _, tr2 := range transactionMonth {
			if tr1 == tr2 {
				spew.Dump(tr2)
				transactionRes[i].TransactionList = append(transactionRes[i].TransactionList, &transaction.TransactionList{
					Amount:          tr2.Amount,
					TransactionName: tr2.TransactionName,
					Date:            tr2.Date,
					DateString:      tr2.DateString,
					CategoryId:      tr2.CategoryId,
					CategoryName:    tr2.CategoryName,
					CategoryColor:   tr2.CategoryColor,
				})
			}
		}
	}

	return c.JSON(common.NewInfoResponse(transactionRes, ""))
}
