package category

type CategoryRequest struct {
	Name            string `json:"name"`
	TransactionType string `json:"transaction_type"`
	Color           uint64 `json:"color"`
}
