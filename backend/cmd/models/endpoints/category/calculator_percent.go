package category

func CalPercent(amount float64, total float64) float64 {
	var percent = 0.00
	percent = (amount / total) * 100
	return percent
}
