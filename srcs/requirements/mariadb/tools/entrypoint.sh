#!/bin/sh
set -e

chown -R mysql:mysql /var/lib/mysql /run/mysqld
chmod 755 /var/run/mysqld

# MariaDBサーバーの初期設定
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    # MariaDBサーバーをバックグラウンドで起動
    mysqld_safe --datadir=/var/lib/mysql --nowatch &

    # MariaDBが起動するのを少し待つ
    i=30
    while [ $i -gt 0 ]; do
        if echo 'SELECT 1' | mysql >/dev/null 2>&1; then
            break
        fi
        echo 'MariaDB starting...'
        sleep 1
        i=$((i - 1))
    done
    if [ "$i" = 0 ]; then
        echo >&2 'MariaDB did not start'
        exit 1
    fi

    # rootパスワードの設定とデータベースの初期設定
    mysql -u root <<-EOSQL
        SET @@SESSION.SQL_LOG_BIN=0;
        DELETE FROM mysql.user ;
        CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASS}' ;
        GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
        FLUSH PRIVILEGES ;
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\` ;
        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}' ;
        GRANT ALL ON \`${MYSQL_DB_NAME}\`.* TO '${MYSQL_USER}'@'%' ;
        FLUSH PRIVILEGES ;
EOSQL

    # MariaDBサーバーをシャットダウン
    if ! mysqladmin -uroot -p"${MYSQL_ROOT_PASS}" shutdown; then
        echo >&2 'MariaDB shutdown failed'
        exit 1
    fi
fi

# オリジナルのCMDを実行
exec "$@"


##!/bin/sh
#
#chown -R mysql:mysql ${MYSQL_DATA_PATH} /run/mysqld
#chmod 755 /run/mysqld
#
#if [ ! -d "${MYSQL_DATA_PATH}" ]; then
#    echo "start initialize db"
#
#    mysql_install_db --user=mysql --datadir="${MYSQL_DATA_PATH}"
#
##    rc-service mariadb setup
##    rc-service mariadb start
#
#    mysqladmin -u root password "${MYSQL_ROOT_PASS}"
#
##    echo "CREATE USER '${MYSQL_USER}' IDENTIFIED BY '${MYSQL_PASS}';" >> /tmp/sql
#    echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_USER} DEFAULT CHARACTER SET utf8;"  >> /tmp/sql
#    echo "grant all privileges on ${MYSQL_USER}.* to ${MYSQL_USER}@'%' identified by '${MYSQL_PASS}' with grant option ;" >> /tmp/sql
#    echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql
#    echo "DROP DATABASE test;" >> /tmp/sql
#    echo "FLUSH PRIVILEGES;" >> /tmp/sql
#    cat /tmp/sql | mysql -u root --password="${MYSQL_ROOT_PASS}"
#    rm /tmp/sql
##    rc-service mariadb stop
#else
#    echo "db already initialized"
##    rc-service mariadb status
##    rc-service mariadb start
##    rc-service mariadb stop
#fi
#
#exec "$@"
##mysqld --user=mysql
