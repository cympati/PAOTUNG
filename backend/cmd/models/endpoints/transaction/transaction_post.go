package transaction

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"paotung-backend/cmd/models/common"
	"paotung-backend/cmd/models/dto/transaction"
	"paotung-backend/pkg/database"
	"paotung-backend/pkg/database/models"
)

func PostHandler(c *fiber.Ctx) error {
	// * Parse user JWT cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Parse body
	body := new(transaction.TransactionRequest)
	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err, Code: "INVALID_INFORMATION",
		}
	}

	var transactionType = body.TransactionType
	var amount = 0.0
	if transactionType == "expense" {
		amount = amount - body.Amount
	} else {
		amount = body.Amount
	}

	var categoryId *uint64
	if body.CategoryId != 0 {
		categoryId = &body.CategoryId
	} else {
		categoryId = nil
	}

	// * Create category record
	transaction := &models.Transaction{
		CategoryId:      categoryId, //  &body.CategoryId ? &body.CategoryId : nill
		Amount:          &amount,
		Date:            &body.Date, // ISOString
		Name:            &body.Name,
		TransactionType: (*models.TransactionType)(&body.TransactionType),
		OwnerId:         claims.UserId,
	}

	if result := database.Gorm.Create(&transaction); result.Error != nil {
		return &common.GenericError{
			Message: "Error create a transaction record",
			Err:     result.Error,
			Code:    "INVALID_INFORMATION",
		}
	}

	// * Cal balance and add into Users Table
	var balance = 0.0
	if balanceResult := database.Gorm.Table("users").Select("balance").Where("id = ?", claims.UserId).Scan(&balance); balanceResult.RowsAffected == 0 {
		return &common.GenericError{
			Message: "User does not exist",
			Err:     balanceResult.Error,
			Code:    "INVALID_INFORMATION",
		}
	}
	// * Update balance
	balance = balance + amount
	if updateBalance := database.Gorm.Model(new(models.User)).Where("id = ?", claims.UserId).Update("balance", balance); updateBalance.Error != nil {
		return &common.GenericError{
			Message: "Unable to update balance",
			Err:     updateBalance.Error,
			Code:    "INVALID_INFORMATION",
		}
	}

	return c.JSON(&common.InfoResponse{
		Success: true,
		Message: "A transaction has been added to system",
		Data: map[string]any{
			"transaction_id": &transaction.Id,
		},
	})
}
