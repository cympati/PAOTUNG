package profile

type InfoRequest struct {
	Email              string `json:"email"`
	UserName           string `json:"user_name"`
	Password           string `json:"password"`
	PathProfilePicture string `json:"path_profile_picture"`
}
