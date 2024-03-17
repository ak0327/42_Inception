# Adminer
#FROM adminer:latest
FROM alpine:3.18

RUN apk add --no-cache \
    curl=8.5.0-r0 \
    php=8.1.27-r0 \
    php-pdo_mysql=8.1.27-r0 \
    php-mbstring=8.1.27-r0 \
    php-session=8.1.27-r0 \
    wget=1.21.4-r0

RUN mkdir -p /var/www/html/ \
    && wget --quiet https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
       -O /var/www/html/index.php

EXPOSE 8080

#CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html", "-d", "display_errors=On"]
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
