package text

import "time"

func ConvertDate(data string) (*time.Time, error) {
	layout := "2006-01-02T15:04:05Z" // Edit format to 'Tue, 12 Feb 2022'
	dataTime, err := time.Parse(layout, data)
	return &dataTime, err
}
