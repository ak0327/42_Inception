#!/bin/sh

set -eu -o pipefail


init_db() {
    mysql_install_db --user=mysql --datadir=${DB_CONTAINER_PATH}
}


start_up_mariadb() {
    mysqld_safe --datadir=${DB_CONTAINER_PATH} --nowatch &

    i=30
    while [ $i -gt 0 ]; do
        if echo 'SELECT 1' | mysql > /dev/null 2>&1; then
            break
        fi
        echo 'MariaDB starting...'
        sleep 1
        i=$(( i - 1 ))
    done
    if [ $i -eq 0 ]; then
        echo >&2 'MariaDB did not start'
        exit 1
    fi
}


shutdown_mariadb() {
    if ! mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown; then
        echo >&2 'MariaDB shutdown failed'
        exit 1
    fi
}


setting_db() {
    mysql -u root <<-EOSQL
        SET @@SESSION.SQL_LOG_BIN=0;
        DELETE FROM mysql.user ;

        CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
        GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
        FLUSH PRIVILEGES ;

        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\` ;

        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;
        GRANT ALL ON \`${MYSQL_DB_NAME}\`.* TO '${MYSQL_USER}'@'%' ;
        FLUSH PRIVILEGES ;
EOSQL
}


main() {
  chown -R mysql:mysql ${DB_CONTAINER_PATH} /run/mysqld
  chmod 755 /var/run/mysqld

  if [ ! -d "${DB_CONTAINER_PATH}/mysql" ]; then
      init_db
      start_up_mariadb
      setting_db
      shutdown_mariadb
  fi
}


main
exec "$@"
