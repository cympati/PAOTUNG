package profile

type Profile struct {
	Email              string  `json:"email"`
	UserName           string  `json:"user_name"`
	PathProfilePicture string  `json:"path_profile_picture"`
	Balance            float64 `json:"balance"`
}
