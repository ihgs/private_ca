package pca

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/exec"
)

type Default struct {
}

func CreateCA(w http.ResponseWriter, r *http.Request) {
	var ca CertificateAuthority

	err := json.NewDecoder(r.Body).Decode(&ca)
	if err != nil {
		http.Error(w, err.Error(), 400)
		return
	}

	caEnvMap := map[string]string{
		"PASSWORD":              ca.PemPassword,
		"COUNTRY_NAME":          ca.Subject.CountryName,
		"STATE_OR_PROVINCE":     ca.Subject.StateOfProvince,
		"LOCALITY_NAME":         ca.Subject.LocalityName,
		"ORG_NAME":              ca.Subject.OrgName,
		"ORG_UNIT":              ca.Subject.OrgUnit,
		"COMMON_NAME":           ca.Subject.CommonName,
		"EMAIL":                 ca.Subject.Email,
		"CHALLENGE_PASSWORD":    ca.Subject.ChallengePassword,
		"OPTIONAL_COMPANY_NAME": ca.Subject.OptionalCompanyName,
		"NUM_DAY":               fmt.Sprint(ca.Days),
		"NUM_CADAY":             fmt.Sprint(ca.Cdays),
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

	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}
