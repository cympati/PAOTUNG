package account

// * Login
type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}
