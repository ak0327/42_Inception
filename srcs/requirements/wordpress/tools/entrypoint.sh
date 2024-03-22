#!/bin/sh
set -eu -o pipefail


if [ ! -f "${WP_PATH}/wp-config.php" ]; then
    wp-cli.phar core download --path="${WP_PATH}" # --allow-root

    wp-cli.phar config create \
      --dbname="${MYSQL_DB_NAME}" \
      --dbuser="${MYSQL_USER}" \
      --dbpass="${MYSQL_PASSWORD}" \
      --dbhost="${WP_DB_HOST}" \
      --path="${WP_PATH}"
      #      --allow-root
    # config create: https://developer.wordpress.org/cli/commands/config/create/

    wp-cli.phar core install \
      --url="${WP_URL}" \
      --title="${WP_TITLE}" \
      --admin_user="${WP_ADMIN_USER}" \
      --admin_password="${WP_ADMIN_PASSWORD}" \
      --admin_email="${WP_ADMIN_EMAIL}" \
      --path="${WP_PATH}" \
#      --allow-root
    # core install: https://developer.wordpress.org/cli/commands/core/install/

    wp-cli.phar user create \
      "${WP_EDITOR_USER}" \
      "${WP_EDITOR_EMAIL}" \
      --role=editor \
      --user_pass="${WP_EDITOR_PASSWORD}" \
      --path="${WP_PATH}"
#      --allow-root
    # user create: https://developer.wordpress.org/cli/commands/user/create/

    # setting for redis cache
    wp-cli.phar config set WP_REDIS_HOST "redis" --type=constant --path="${WP_PATH}"
    wp-cli.phar config set WP_REDIS_PORT "6379" --type=constant --path="${WP_PATH}"
    wp-cli.phar config set WP_REDIS_DATABASE "0" --type=constant --path="${WP_PATH}"
    wp-cli.phar config set WP_REDIS_PREFIX '${WP_URL}' --type=constant --path="${WP_PATH}"
    wp-cli.phar config set WP_CACHE true --raw --type=constant --path="${WP_PATH}"

    wp-cli.phar plugin install redis-cache --activate --path="${WP_PATH}" # --allow-root

    wp-cli.phar redis enable --path="${WP_PATH}"
    wp-cli.phar redis status --path="${WP_PATH}"

    wp-cli.phar config set WP_DEBUG true --raw --type=constant --path="${WP_PATH}"
    wp-cli.phar config set WP_DEBUG_LOG true --raw --type=constant --path="${WP_PATH}"
    wp-cli.phar config set WP_DEBUG_DISPLAY true --raw --type=constant --path="${WP_PATH}"

fi

chown -R nobody:nobody "${WP_PATH}"
chmod -R 755 "${WP_PATH}"

exec "$@"
