package common

type UserClaim struct {
	UserId *uint64 `json:"user_id"`
}

func (T *UserClaim) Valid() error {
	return nil
}
