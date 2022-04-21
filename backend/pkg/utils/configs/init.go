package configs

import (
	"io/ioutil"

	"log"

	"gopkg.in/yaml.v2"
)

var C = new(config) // big capital is public

func init() {
	// Load configurations to struct
	yml, err := ioutil.ReadFile("config.yml")
	if err != nil {
		println("UNABLE TO READ YAML CONFIGURATION FILE")
		log.Fatalf("error: %s", err.Error())
	}
	err = yaml.Unmarshal(yml, C)
	if err != nil {
		println("UNABLE TO PARSE YAML CONFIGURATION FILE")
		log.Fatalf("error: %s", err.Error())
	}
}
