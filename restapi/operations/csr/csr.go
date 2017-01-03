package csr

import (
  "fmt"
  "io"
  "io/ioutil"
  "os"
  "os/exec"

  middleware "github.com/go-openapi/runtime/middleware"
  "github.com/go-openapi/swag"
)

// Sign csr
func Sign(params SignCsrParams)  middleware.Responder {
  uploadedFile := params.Csr.Data
  sFile, err := ioutil.TempFile("","src")
  if err != nil {
    panic(err)
  }
  defer sFile.Close()
  _, err = io.Copy(sFile, uploadedFile)
  if err != nil {
    panic(err)
  }
  sFilePath := sFile.Name()

  dFile, err := ioutil.TempFile("","dist")
  if err != nil {
    panic(err)
  }
  dFilePath := dFile.Name()

  cmd := exec.Command("/opt/PCA/bin/sign_csr.sh", "")
  envArray := os.Environ()
  envArray = append(envArray, "CSR_PATH="+sFilePath)
  envArray = append(envArray, "SIGNED_CSR_PATH="+dFilePath)
  envArray = append(envArray, "PASSWORD="+swag.StringValue(params.PemPassword))

  cmd.Env = envArray

  out, err := cmd.CombinedOutput()
  if err != nil {
    panic(err)
  }

  fmt.Println(string(out))

  downloadFile, err := ioutil.ReadFile(dFilePath)
  if err != nil {
    panic(err)
  }

  return NewSignCsrOK().WithPayload(string(downloadFile))
}
