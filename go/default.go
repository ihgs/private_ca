package pca

import (
	"net/http"
)

type Default struct {

}

func CreateCA(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")
		w.WriteHeader(http.StatusOK)
}

