#!/bin/bash


expect -c "
spawn openssl ca -in "${CSR_PATH}" -keyfile /etc/pki/CA/private/cakey.pem -cert /etc/pki/CA/cacert.pem -out "${SIGNED_CSR_PATH}" -policy policy_anything -batch
expect \"Enter pass phrase for /etc/pki/CA/private/cakey.pem:\"
send \"${PASSWORD}\n\"
expect eof;
"
