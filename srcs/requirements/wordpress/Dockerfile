# Wordpress and php-pfm
FROM alpine:3.18

# PHP
RUN apk add --no-cache \
    curl=8.5.0-r0 \
    icu-data-full=73.2-r2 \
    php81=8.1.27-r0 \
    php81-ctype=8.1.27-r0 \
    php81-curl=8.1.27-r0 \
    php81-dom=8.1.27-r0 \
    php81-fpm=8.1.27-r0 \
    php81-intl=8.1.27-r0 \
    php81-mbstring=8.1.27-r0 \
    php81-mysqli=8.1.27-r0 \
    php81-openssl=8.1.27-r0 \
    php81-pecl-redis=6.0.2-r0 \
    php81-phar=8.1.27-r0 \
    php81-session=8.1.27-r0 \
    php81-tokenizer=8.1.27-r0 \
    php81-xml=8.1.27-r0 \
    php81-xmlreader=8.1.27-r0 \
    redis=7.0.15-r0  # for redis-cli test

# WP-CLI
RUN curl --silent -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar  \
    && mv wp-cli.phar /usr/local/bin/wp-cli.phar
# wp -> wp-cli.phar https://github.com/wp-cli/config-command/issues/31

ENV WP_CONTAINER_PATH="/var/www/html"
RUN mkdir -p "${WP_CONTAINER_PATH}" /var/www/html/wp-content/logs \
    && chown -R nobody:nobody "${WP_CONTAINER_PATH}" \
    && chmod -R 775 "${WP_CONTAINER_PATH}"

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

EXPOSE 9000

COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm81", "-F"]
