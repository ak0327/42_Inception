#!/bin/sh

set -eu -o pipefail

FTP_USER=${FTP_USER:?}
FTP_PASSWORD=${FTP_PASSWORD:?}
PUBLIC_HOST=${PUBLIC_HOST:?}

if ! id "$FTP_USER" &>/dev/null; then
    adduser -D -h "$WP_CONTAINER_PATH" "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

echo "$PUBLIC_HOST" > /etc/pure-ftpd/conf/ForcePassiveIP
echo "30000" > /etc/pure-ftpd/conf/PassivePortRange
echo "no" > /etc/pure-ftpd/conf/NoAnonymous
echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone

chown "$FTP_USER":"$FTP_USER" "$WP_CONTAINER_PATH"
chmod 755 "$WP_CONTAINER_PATH"

exec "$@"
