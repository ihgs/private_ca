#!/bin/sh

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
send \"\n\"
expect \"Enter PEM pass phrase:\"
send \"${PASSWORD}\n\"
expect \"Verifying - Enter PEM pass phrase:\"
send \"${PASSWORD}\n\"
expect \"Country Name (2 letter code) \"
send \"${COUNTRY_NAME}\n\"
expect \"State or Province Name (full name) \"
send \"${STATE_OR_PROVINCE}\n\"
expect \"Locality Name\"
send \"${LOCALITY_NAME}\n\"
expect \"Organization Name (eg, company)\"
send \"${ORG_NAME}\n\"
expect \"Organizational Unit Name\"
send \"${ORG_UNIT}\n\"
expect \"Common Name\"
send \"${COMMON_NAME}\n\"
expect \"Email Address\"
send \"${EMAIL}\n\"
expect \"A challenge password\"
send \"${CHALLENGE_PASSWORD}\n\"
expect \"An optional company name\"
send \"${OPTIONAL_COMPANY_NAME}\n\"
expect \"Enter pass phrase\"
send \"${PASSWORD}\n\"
expect eof;
"
