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
			Err:     err,
		}
	}

	// * Create category record
	transaction := &models.Transaction{
		CategoryId:      &body.CategoryId,
		Amount:          &body.Amount,
		Date:            &body.Date,
		Name:            &body.Name,
		TransactionType: (*models.TransactionType)(&body.TransactionType),
		OwnerId:         claims.UserId,
	}

	if result := database.Gorm.Create(&transaction); result.Error != nil {
		return &common.GenericError{
			Message: "Error create a transaction record",
			Err:     result.Error,
		}
	}

	// * Cal balance and add into Users Table
	//var balance = 0.0

	return c.JSON(&common.InfoResponse{
		Success: true,
		Message:    "A transaction has been added to system",
		Data: map[string]any{
			"transaction_id": &transaction.Id,
		},
	})
}
