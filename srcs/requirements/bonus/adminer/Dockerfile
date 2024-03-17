# Adminer
#FROM adminer:latest
FROM alpine:3.18

RUN apk add --no-cache \
    curl \
    php \
    php-pdo_mysql \
    php-mbstring \
    php-session \
    wget

RUN mkdir -p /var/www/html/ \
    && wget --quiet https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
       -O /var/www/html/index.php

EXPOSE 8080

#CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html", "-d", "display_errors=On"]
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
