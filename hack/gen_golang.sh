#!/bin/bash
#
# go get -u github.com/go-swagger/go-swagger/cmd/swagger
#
swagger generate server -f api/swagger.yaml -A pca
