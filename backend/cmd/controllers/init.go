package controllers

import (
	"github.com/gofiber/fiber/v2"
	"paotung-backend/pkg/fiber/middlewares"

	// 	"paotung-backend/pkg/utils/config"
	Account "paotung-backend/cmd/models/endpoints/account"
	Category "paotung-backend/cmd/models/endpoints/category"
	Profile "paotung-backend/cmd/models/endpoints/profile"
)

func Init(router fiber.Router) {
	// * Account
	account := router.Group("account/")
	account.Post("login", Account.Login)
	account.Post("register", Account.Register)
	//
	//// * Profile
	profile := router.Group("profile/", middlewares.Jwt)
	profile.Get("info", Profile.GetHandler)
	profile.Patch("update", Profile.PatchHandler)
	//
	//// * Transaction
	//transaction := router.Group("transaction/", middlewares.Jwt)
	//transaction.Get("info/:user_id", transaction.GetHandler)
	//transaction.Get(":transaction_id/:user_id/week", transaction.GetTransactionWeekHandler)
	//transaction.Post(":user_id", transaction.PostHandler)
	//
	//// * Category
	category := router.Group("category/", middlewares.Jwt)
	category.Get("expense", Category.GetExpenseHandler)
	category.Get("income", Category.GetIncomeHandler)
	category.Post("add", Category.PostHandler)
	//category.Delete("delete/:category_id", category.DeleteByIdHandler)
	//category.Delete("delete/all", category.DeleteAllHandler)
	//
	//// * Notification
	//notification := router.Group("notification/", middlewares.Jwt)
	//notification.Get("info/:user_id", notification.GetHandler)
	//notification.Post(":user_id", notification.PostHandler)
	//notification.Delete(":notification_id/:user_id", notification.DeleteHandler)

}
