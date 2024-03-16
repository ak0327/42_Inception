FROM wordpress:latest

# wp-config.phpにデバッグモードを有効にする設定を追加

RUN sed -i "/^\/\* That's all, stop editing! Happy publishing. \*\/$/i define('WP_DEBUG', true);" /usr/src/wordpress/wp-config-sample.php

## Wordpress and php-pfm
#FROM alpine:3.18
#
## PHP
#RUN apk add --no-cache \
#    php81 \
#    php81-ctype \
#    php81-curl \
#    php81-dom \
#    php81-fpm \
#    php81-intl \
#    php81-json \
#    php81-mbstring \
#    php81-mysqli \
#    php81-openssl \
#    php81-phar \
#    php81-session \
#    php81-xml \
#    php81-xmlreader \
#    php81-zlib
#
## Wordpress
#RUN apk add --no-cache wget \
#    && wget https://wordpress.org/latest.tar.gz \
#    && mkdir -p /var/www/html \
#    && tar -xzf latest.tar.gz -C /var/www/html \
#    && rm latest.tar.gz \
#    && chown -R nobody:nobody /var/www/html
#
#WORKDIR /var/www/html
#
#RUN mkdir -p /var/www/html/wp-content/logs
#
#EXPOSE 9000
#
#CMD ["php-fpm81", "-F"]
##CMD ["php-fpm"]
