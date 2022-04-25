package account

// * Login
type loginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

// * Register
type registerRequest struct {
	Email    string `json:"email"`
	Username string `json:"user_name"`
	Password string `json:"password"`
}

// * Response
type response struct {
	Success bool   `json:"success"`
	Token   string `json:"token"`
	Message string `json:"message"`
}

//type RegisterResponse struct {
//	EmailValidated   bool   `json:"email_validated"`
//	EmailSuffix      string `json:"email_suffix"`
//	OrganizationName string `json:"organization_name"`
//	FacultyName      string `json:"faculty_name"`
//}
