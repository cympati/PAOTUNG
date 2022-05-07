package text

func NilFallback[T any](pointer *T, defaultValue ...T) T {
	var variable T
	if pointer != nil {
		variable = *pointer
	} else if len(defaultValue) > 0 {
		variable = defaultValue[0]
	}
	return variable
}
