package models

type TransactionType string

const (
	income  TransactionType = "income"
	expense TransactionType = "expense"
)

var TransactionTypes = struct {
	Income  TransactionType
	Expense TransactionType
}{
	Income:  income,
	Expense: expense,
}
