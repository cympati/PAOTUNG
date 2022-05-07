package notification

import "time"

type Notification struct {
	Id       uint64    `json:"id"`
	Name     string    `json:"name"`
	DateTime time.Time `json:"date_time"`
}
