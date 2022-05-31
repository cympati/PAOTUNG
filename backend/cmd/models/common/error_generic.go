package common

type GenericError struct {
	Code    string `json:"code"`
	Message string `json:"message"`
	Err     error  `json:"error"`
}

func (v *GenericError) Error() string {
	return v.Message
}
