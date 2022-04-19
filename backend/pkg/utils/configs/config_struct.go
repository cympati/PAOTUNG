package configs

type config struct {
	Environment environment

	Address string
	// ServerHeader string
	Cors []string

	// JwtSecret       string

	// MySqlDsn     string
	// MySqlMigrate bool

	// InternalIps   []string
	// InternalAuths []struct {
	// 	Username string
	// 	Password string
	// }

	// MsJwtPublicKey  string
	// MsJwtPrivateKey string
}
