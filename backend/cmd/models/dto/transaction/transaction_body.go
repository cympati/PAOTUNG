package transaction

import "time"

type TransactionRequest struct {
	CategoryId      uint64    `json:"category_id"`
	Amount          float64   `json:"amount"`
	Name            string    `json:"name"`
	TransactionType string    `json:"transaction_type"`
	Date            time.Time `json:"date"` // ISOString
}
