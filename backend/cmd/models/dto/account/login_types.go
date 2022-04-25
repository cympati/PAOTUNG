package account

type request struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type response struct {
	Success bool   `json:"success"`
	Token   string `json:"token"`
}
