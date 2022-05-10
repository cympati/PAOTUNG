package category

type CategoryList struct {
	CategoryId    uint64  `json:"category_id"`
	Amount        float64 `json:"total"`
	CategoryName  string  `json:"category_name"`
	CategoryColor uint64  `json:"category_color"`
	Percent       float64 `json:"percent"`
}

type CategoryNameList struct {
	Id   uint64 `json:"category_id"`
	Name string `json:"category_name"`
}
