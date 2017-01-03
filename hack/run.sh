#!/bin/bash

docker build -t ca_for_test .
docker run -it --rm -p 8080:8080 --name pca ca_for_test
