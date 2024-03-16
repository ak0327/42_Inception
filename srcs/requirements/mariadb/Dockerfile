# MariaDB
FROM alpine:3.18

RUN apk add --no-cache \
    mariadb \
    mariadb-client

RUN mkdir -p /var/lib/mysql /var/run/mysqld
#    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
#    && chmod 755 /var/run/mysqld

COPY conf/my.cnf /etc/mysql/my.cnf

COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql"]
