#!/bin/bash
BASE_DIR=`dirname $0`/../

pushd $BASE_DIR
docker run --rm -v "$PWD":/go/src/github.com/ihgs/private_ca -w /go/src/github.com/ihgs/private_ca golang:1.6 bash -c "go get; go build"
popd
