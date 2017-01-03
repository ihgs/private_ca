package ca

import (
    "fmt"
    "os"
    "os/exec"
    middleware "github.com/go-openapi/runtime/middleware"
    "github.com/go-openapi/swag"
)

// Create CA operation
func Create(params CreateCAParams) middleware.Responder {

  ca := params.CertificateAuthority

  caEnvMap := map[string]string{
  "PASSWORD":              ca.PemPassword,
  "COUNTRY_NAME":          swag.StringValue(ca.Subject.CountryName),
  "STATE_OR_PROVINCE":     swag.StringValue(ca.Subject.StateOfProvince),
  "LOCALITY_NAME":         swag.StringValue(ca.Subject.LocalityName),
  "ORG_NAME":              swag.StringValue(ca.Subject.OrgName),
  "ORG_UNIT":              swag.StringValue(ca.Subject.OrgUnit),
  "COMMON_NAME":           swag.StringValue(ca.Subject.CommonName),
  "EMAIL":                 swag.StringValue(ca.Subject.Email),
  "CHALLENGE_PASSWORD":    ca.Subject.ChallengePassword,
  "OPTIONAL_COMPANY_NAME": ca.Subject.OptionalCompanyName,
  "NUM_DAY":               fmt.Sprint(swag.Int32Value(ca.Days)),
  "NUM_CADAY":             fmt.Sprint(swag.Int32Value(ca.Cdays)),
  }

  envArray := os.Environ()
	for key, value := range caEnvMap {
		envArray = append(envArray, key+"="+ value)
	}

	cmd := exec.Command("/bin/bash", "/opt/PCA/bin/create_ca.sh")
	cmd.Env = envArray
	out, err := cmd.CombinedOutput()
	if err != nil {
		panic(err)
	}
  fmt.Println(string(out))

  return NewCreateCAOK()
}
