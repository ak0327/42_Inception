#FROM wordpress:latest

# Wordpress and php-pfm
FROM alpine:3.18

# PHP
RUN apk add --no-cache \
    curl \
    php81 \
    php81-ctype \
    php81-curl \
    php81-dom \
    php81-fpm \
    php81-intl \
    php81-json \
    php81-mbstring \
    php81-mysqli \
    php81-openssl \
    php81-phar \
    php81-session \
    php81-xml \
    php81-xmlreader \
    php81-zlib \
    icu-data-full

# WP-CLI
RUN curl --silent -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar  \
    && mv wp-cli.phar /usr/local/bin/wp-cli.phar
# wp -> wp-cli.phar https://github.com/wp-cli/config-command/issues/31

ENV WP_PATH="/var/www/html"
RUN mkdir -p "${WP_PATH}" \
    && chmod 755 "${WP_PATH}" \
    && chown -R nobody:nobody "${WP_PATH}" \
    && wp-cli.phar core download --allow-root --path="${WP_PATH}"

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
#COPY tools/helthcheck.php /var/www/html/healthcheck.php

RUN mkdir -p /var/www/html/wp-content/logs

EXPOSE 9000

COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm81", "-F"]
