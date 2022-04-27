package common

type GenericError struct {
	Code    string
	Message string
	Err     error
}

func (v *GenericError) Error() string {
	return v.Message
}
