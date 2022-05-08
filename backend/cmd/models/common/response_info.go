package common

type InfoResponse struct {
	Success bool        `json:"success"`
	Code    string      `json:"code"`
	Message string      `json:"message,omitempty"`
	Data    interface{} `json:"data,omitempty"`
}

func NewInfoResponse(data any, msg string) *InfoResponse {
	return &InfoResponse{
		Success: true,
		Message: msg,
		Code:    "DATA",
		Data:    data,
	}
}
