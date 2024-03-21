#!/bin/sh

mkdir -p ${CRT_DIR}

# ssl certificate
## x509  : self-signed certificate
## noenc : private key is created it will not be encrypted.
## newkey: generates RSA key 2048 bits
## keyout: save path for selfsigned key
## out   : save path for selfsigned certificate
## subj  :
openssl req \
        -x509 \
        -noenc \
        -newkey rsa:${RSA_KEY_BITS} \
        -out ${CRT_DIR}/inception.crt \
        -keyout ${CRT_DIR}/inception.key \
        -subj "/C=${COUNTRY}/ST=${STATE}/O=${ORGANIZATION}/CN=${WP_DOMAIN}"

openssl req \
        -x509 \
        -noenc \
        -newkey rsa:${RSA_KEY_BITS} \
        -out ${CRT_DIR}/inception_hugo.crt \
        -keyout ${CRT_DIR}/inception_hugo.key \
        -subj "/C=${COUNTRY}/ST=${STATE}/O=${ORGANIZATION}/CN=${HUGO_DOMAIN}"


envsubst '${WP_DOMAIN},${HUGO_DOMAIN},${CRT_DIR}' \
          < /etc/nginx/http.d/default.conf.template \
          > /etc/nginx/http.d/default.conf

exec "$@"

## CA
#mkdir demoCA
#echo "01" > demoCA/serial
#echo "00" > demoCA/crlnumber
#touch demoCA/index.txt
#
#CERT_CA_NAME=ca
#openssl genrsa 2048 > $CERT_CA_NAME.key
#
#openssl req \
#        -new \
#        -subj "/C=JP/ST=Tokyo/O=$CERT_CA_NAME/CN=$CERT_CA_NAME" \
#        -key $CERT_CA_NAME.key \
#        -out $CERT_CA_NAME.csr
#
#openssl ca \
#        -selfsign \
#        -batch \
#        -days 3650 \
#        -extensions v3_ca \
#        -outdir . \
#        -keyfile $CERT_CA_NAME.key \
#        -in $CERT_CA_NAME.csr \
#        -out $CERT_CA_NAME.crt
#
## Server
#CERT_NAME=cert
#openssl genrsa 2048 > $CERT_NAME.key
#
#SUBJECT_ALT="subjectAltName = DNS:localhost"
#openssl req \
#        -new \
#        -x509 \
#        -subj "/C=JP/ST=Tokyo/O=$CERT_CA_NAME/CN=$CERT_NAME" \
#        -extensions v3_req \
#        -addext "$SUBJECT_ALT" \
#        -key $CERT_NAME.key \
#        -out $CERT_NAME.csr
#
#openssl x509 \
#        -text \
#        -days 365 \
#        -CA $CERT_CA_NAME.crt \
#        -CAkey $CERT_CA_NAME.key \
#        -in $CERT_NAME.csr \
#        -out $CERT_NAME.crt
# https://qiita.com/betarium/items/2b396953543331545a44


