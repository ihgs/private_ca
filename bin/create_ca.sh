#!/bin/bash

PASSWORD=${PASSWORD:-capassword}
COUNTRY_NAME=${COUNTRY_NAME:-JP}
STATE_OR_PROVINCE=${STATE_OR_PROVINCE:-Kanagawa}
LOCALITY_NAME=${LOCALITY_NAME:-Yokohama}
ORG_NAME=${ORG_NAME:-Test Company}
ORG_UNIT=${ORG_UNIT:-Test unit}
COMMON_NAME=${COMMON_NAME:-*.local}
EMAIL=${EMAIL:-ca@example.com}
CHALLENGE_PASSWORD=${CHALLENGE_PASSWORD:-}
OPTIONAL_COMPANY_NAME=${OPTIONAL_COMPANY_NAME:-}
NUM_DAY=${NUM_OF_DAY:-365}
DAYS="-days ${NUM_DAY}"
NUM_CADAY=${NUM_OF_CADAY:-1095}
CADAYS="-days ${NUM_CADAY}"

export DAYS CADAYS

expect -c "
spawn /etc/pki/tls/misc/CA -newca
expect \"CA certificate filename (or enter to create)\"
send \"\r\"
expect \"Enter PEM pass phrase:\"
send \"${PASSWORD}\r\"
expect \"Verifying - Enter PEM pass phrase:\"
send \"${PASSWORD}\r\"
expect \"Country Name (2 letter code) \"
send \"${COUNTRY_NAME}\r\"
expect \"State or Province Name (full name) \"
send \"${STATE_OR_PROVINCE}\r\"
expect \"Locality Name\"
send \"${LOCALITY_NAME}\r\"
expect \"Organization Name (eg, company)\"
send \"${ORG_NAME}\r\"
expect \"Organizational Unit Name\"
send \"${ORG_UNIT}\r\"
expect \"Common Name\"
send \"${COMMON_NAME}\r\"
expect \"Email Address\"
send \"${EMAIL}\r\"
expect \"A challenge password\"
send \"${CHALLENGE_PASSWORD}\r\"
expect \"An optional company name\"
send \"${OPTIONAL_COMPANY_NAME}\r\"
expect \"Enter pass phrase\"
send \"${PASSWORD}\r\"
expect eof
"
