package controllers

import (
	"github.com/gofiber/fiber/v2"
	// 	"paotung-backend/pkg/utils/config"
	Account "paotung-backend/cmd/models/endpoints/account"
)

func Init(router fiber.Router) {
	// * Account
	account := router.Group("account/")
	account.Post("login", Account.Login)
	//account.Post("register", account.Register)
	//
	//// * Profile
	//profile := router.Group("profile/", middlewares.Jwt)
	//profile.Get("info/:user_id", profile.GetHandler)
	//profile.Patch(":user_id", profile.PatchHandler)
	//
	//// * Transaction
	//transaction := router.Group("transaction/", middlewares.Jwt)
	//transaction.Get("info/:user_id", transaction.GetHandler)
	//transaction.Get(":transaction_id/:user_id/week", transaction.GetTransactionWeekHandler)
	//transaction.Post(":user_id", transaction.PostHandler)
	//
	//// * Category
	//category := router.Group("category/", middlewares.Jwt)
	//category.Get("info/:user_id", category.GetHandler)
	//category.Get(":user_id/expenses", category.GetExpenseCategoryHandler)
	//category.Get(":user_id/income", category.GetIncomeCategoryHandler)
	//category.Post(":user_id", category.PostHandler)
	//category.Delete(":category_id/:user_id", category.DeleteHandler)
	//
	//// * Notification
	//notification := router.Group("notification/", middlewares.Jwt)
	//notification.Get("info/:user_id", notification.GetHandler)
	//notification.Post(":user_id", notification.PostHandler)
	//notification.Delete(":notification_id/:user_id", notification.DeleteHandler)

}
