#!/bin/sh

mkdir -p ${CRT_DIR}

# ssl certificate
## wordpress page
openssl req \
        -x509 \
        -noenc \
        -newkey rsa:${RSA_KEY_BITS} \
        -out ${CRT_DIR}/inception.crt \
        -keyout ${CRT_DIR}/inception.key \
        -subj "/C=${COUNTRY}/ST=${STATE}/O=${ORGANIZATION}/CN=${WP_DOMAIN}" > /dev/null 2>&1

## hugo page
openssl req \
        -x509 \
        -noenc \
        -newkey rsa:${RSA_KEY_BITS} \
        -out ${CRT_DIR}/inception_hugo.crt \
        -keyout ${CRT_DIR}/inception_hugo.key \
        -subj "/C=${COUNTRY}/ST=${STATE}/O=${ORGANIZATION}/CN=${HUGO_DOMAIN}" > /dev/null 2>&1


# conf
envsubst '${WP_DOMAIN},${HUGO_DOMAIN},${CRT_DIR}' \
          < /etc/nginx/http.d/default.conf.template \
          > /etc/nginx/http.d/default.conf

exec "$@"
