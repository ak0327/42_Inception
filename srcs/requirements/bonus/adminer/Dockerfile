# Adminer
FROM alpine:3.18

RUN apk add --no-cache \
    php81 \
    php81-pdo_mysql \
    wget

RUN mkdir -p /var/www/html/ \
    && wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
       -O /var/www/html/adminer.php

EXPOSE 8080

CMD ["php81", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
