package account

type request struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type response struct {
	Success bool   `json:"success"`
	IsLogin bool   `json:"isLogin"`
	Token   string `json:"token"`
}
