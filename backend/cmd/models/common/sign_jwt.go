package common

import (
	"fmt"

	"github.com/golang-jwt/jwt/v4"

	"paotung-backend/cmd/models/common"
	"paotung-backend/pkg/utils/configs"
)

func SignJwt(claim *common.UserClaim) (string, *common.GenericError) {
	// * Create token
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claim)

	// * Generate signed token string
	if signedToken, err := token.SignedString([]byte(configs.C.JwtSecret)); err != nil {
		return "", &common.GenericError{
			Message: "Unable to sign JWT token",
			Err:     err,
		}
	} else {
		fmt.Sprint(signedToken)
		return signedToken, nil
	}
}
