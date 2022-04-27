package common

type InfoResponse struct {
	Success bool        `json:"success"`
	Code    string      `json:"code"`
	Info    string      `json:"info,omitempty"`
	Data    interface{} `json:"data,omitempty"`
}

func NewInfoResponse(data any) *InfoResponse {
	return &InfoResponse{
		Success: true,
		Code:    "DATA",
		Data:    data,
	}
}
