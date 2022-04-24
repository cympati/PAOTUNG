package account

type request struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type response struct {
	Success bool   `json:"success"`
	Token   string `json:"token"`
}
