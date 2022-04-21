package configs

type config struct {
	Environment environment
	Address     string
	Cors        []string
	JwtSecret   string
	MySqlDsn    string
}
