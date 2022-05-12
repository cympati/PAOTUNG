package transaction

import "github.com/gofiber/fiber/v2"

func GetHandler(c *fiber.Ctx) error {
	// * Format: {transaction_info:{}, category_info:{}}
	// * Query transaction_info --> use date to check TodayList is exist or not
	// * Check if category is null --> change color and category_name to empty string

	// * Query category_info

	// * When return don't forgot to change date to string as 'Tue, 12 Feb 2022'
	// * Check if transaction_type is expense --> chancge form to '-xxx'

	return nil
}
