# NGINX
FROM alpine:3.18

RUN apk add --no-cache \
    curl \
    nginx \
    openssl

# nginx
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/http.d/default.conf

# ssl certificate
## x509  : self-signed certificate
## noenc : private key is created it will not be encrypted.
## newkey: generates RSA key 2048 bits
## keyout: save path for selfsigned key
## out   : save path for selfsigned certificate
## subj  :
RUN mkdir -p /etc/nginx/ssl \
    && openssl req \
    -x509 \
    -noenc \
    -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=JP/ST=Tokyo/L=city/O=42Tokyo/CN=takira.42.fr"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
