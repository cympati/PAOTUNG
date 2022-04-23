package array

func Contains[T any](arr []*T, elem *T) bool {
	for _, a := range arr {
		if a == elem {
			return true
		}
	}
	return false
}
