#!/bin/sh

mkdir -p /etc/nginx/ssl

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
        -newkey rsa:2048 \
        -out /etc/nginx/ssl/inception.crt \
        -keyout /etc/nginx/ssl/inception.key \
        -subj "/C=JP/ST=Tokyo/L=city/O=42Tokyo/CN=takira.42.fr"

openssl req \
        -x509 \
        -noenc \
        -newkey rsa:2048 \
        -out /etc/nginx/ssl/inception_hugo.crt \
        -keyout /etc/nginx/ssl/inception_hugo.key \
        -subj "/C=JP/ST=Tokyo/L=city/O=42Tokyo/CN=takira.hugo.com"

exec "$@"

#mkdir demoCA
#echo "01" > demoCA/serial
#echo "00" > demoCA/crlnumber
#touch demoCA/index.txt