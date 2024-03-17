#!/bin/sh
set -eu -o pipefail

if [ ! -f "${WP_PATH}/wp-config.php" ]; then
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
fi


exec "$@"
