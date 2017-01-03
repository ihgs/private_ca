#!/bin/sh

KEY_PASS=${KEY_PASS:-newkey}

PASSWORD=${PASSWORD:-capassword}
COUNTRY_NAME=${COUNTRY_NAME:-JP}
STATE_OR_PROVINCE=${STATE_OR_PROVINCE:-Kanagawa}
LOCALITY_NAME=${LOCALITY_NAME:-Yokohama}
ORG_NAME=${ORG_NAME:-Default Company Ltd}
ORG_UNIT=${ORG_UNIT:-Test unit}
COMMON_NAME=${COMMON_NAME:-example.com}
EMAIL=${EMAIL:-ca@example.com}
CHALLENGE_PASSWORD=${CHALLENGE_PASSWORD:-}
OPTIONAL_COMPANY_NAME=${OPTIONAL_COMPANY_NAME:-}

if [ -z "$DAYS" ] ; then DAYS="-days 1461" ; fi

expect -c "
spawn openssl genrsa -aes256 -out newkey.pem 4096
expect \"Enter pass phrase\"
send \"${KEY_PASS}\n\"
expect \"Verifying - Enter\"
send \"${KEY_PASS}\n\"
expect
"

expect -c "
spawn openssl req -new -key newkey.pem -out newreq.pem $DAYS
expect \"Enter pass phrase\"
send \"${KEY_PASS}\n\"
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

"

expect -c "
spawn openssl ca -policy policy_anything -out newcert.pem $DAYS -infiles newreq.pem
expect \"Enter pass phrase\"
send \"${PASSWORD}\n\"
"

cat newcert.pem
echo "Signed certificate is in newcert.pem, private key is in newkey.pem"
