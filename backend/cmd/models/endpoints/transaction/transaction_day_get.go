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

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	//spew.Dump("dasdsdsads")
	var transactionToday []*transaction.TransactionList
	// * Query transaction_info --> use date to check TodayList is exist or not, and query category_info
	result := database.Gorm.Table("transactions").
		Select("transactions.name as transaction_name, transactions.date, transactions.amount, transactions.category_id as category_id, categories.name as category_name, categories.color as category_color").
		Where("tran sactions.owner_id = ? AND transactions.date <= ? AND transactions.date > ?", claims.UserId, time.Now(), time.Now().AddDate(0, 0, -1)).
		Joins("left join categories on categories.id = transactions.category_id").
		Order("date desc").Scan(&transactionToday)
	if result.Error != nil || result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "Error querying transaction and category information",
			Err:     result.Error,
		}
	}

	//spew.Dump(transactionToday)

	// * Check if category is null --> change color and category_name to empty string
	for _, trans := range transactionToday {
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
	for _, val := range transactionToday {
		spew.Dump(val.Date)
		dt, _ := time.Parse(time.RFC3339, val.Date.String())
		spew.Dump(dt) // 1999-12-31 00:00:00 +0000 UTC
		formatDate = dt.Format(layoutUS)
		spew.Dump(formatDate) // Tue, 12 Feb 2022
		val.DateString = formatDate
		spew.Dump(val.DateString)
	}

	//transactionRes := &transaction.TransactionResponse{
	//	Date:            formatDate,
	//	TransactionList: append(transactionToday, &transaction.TransactionList{}),
	//}

	//for _, tr1 := range transactionToday {
	//	spew.Dump(tr1.DateString)
	//	for _, tr2 := range transactionToday {
	//		transactionRes.Date = tr1.DateString
	//		if tr1 == tr2 {
	//			spew.Dump(tr2)
	//			transactionRes.TransactionList = append(transactionRes.TransactionList, tr2)
	//			spew.Dump(transactionRes.TransactionList)
	//		}
	//	}
	//}

	//spew.Dump(transactionRes)

	return c.JSON(common.NewInfoResponse(transactionToday, ""))
}
