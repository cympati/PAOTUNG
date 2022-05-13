package notification

import "time"

type NotificationRequest struct {
	Name     string    `json:"name"`
	DateTime time.Time `json:"date_time"`
}
