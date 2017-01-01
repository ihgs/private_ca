#!/bin/bash
#
# brew install swagger-codegen
#

BASE_DIR=`dirname $0`/../

swagger-codegen generate -i "${BASE_DIR}api/swagger.yaml" -l go-server -c "${BASE_DIR}api/go-server.conf"
swagger-codegen generate -i "${BASE_DIR}api/swagger.yaml" -l go -c "${BASE_DIR}api/go-server.conf" -o tmp
mv tmp/certificate_authority.go go
mv tmp/subject.go go
mv tmp/error_model.go go
