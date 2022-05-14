package controllers

import (
	"github.com/gofiber/fiber/v2"
	"paotung-backend/pkg/fiber/middlewares"

	// 	"paotung-backend/pkg/utils/config"
	Account "paotung-backend/cmd/models/endpoints/account"
	Category "paotung-backend/cmd/models/endpoints/category"
	Notification "paotung-backend/cmd/models/endpoints/notification"
	Profile "paotung-backend/cmd/models/endpoints/profile"
	Transaction "paotung-backend/cmd/models/endpoints/transaction"
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
	transaction := router.Group("transaction/", middlewares.Jwt)
	transaction.Get("today", Transaction.GetHandler)
	transaction.Get("month", Transaction.GetMonthHandler)
	transaction.Post("add", Transaction.PostHandler)
	//
	//// * Category
	category := router.Group("category/", middlewares.Jwt)
	category.Get("all", Category.GetHandler)
	category.Get("expense", Category.GetExpenseHandler)
	category.Get("income", Category.GetIncomeHandler)
	category.Post("add", Category.PostHandler)
	category.Delete("delete/all", Category.DeleteAllHandler)
	category.Delete("delete/:category_id", Category.DeleteByIdHandler)

	//
	//// * Notification
	notification := router.Group("notification/", middlewares.Jwt)
	notification.Get("info", Notification.GetHandler)
	notification.Post("add", Notification.PostHandler)
	notification.Delete("delete/all", Notification.DeleteAllHandler)
	notification.Delete("delete/:notification_id", Notification.DeleteByIdHandler)

}
