package transaction

import (
	"time"
)

type TransactionList struct {
	Amount          float64   `json:"amount"`
	TransactionName string    `json:"transaction_name"`
	Date            time.Time `json:"date"` // ISOString
	DateString      string    `json:"date_string"`
	CategoryId      uint64    `json:"category_id"`
	CategoryName    string    `json:"category_name"`
	CategoryColor   int       `json:"category_color"`
}
