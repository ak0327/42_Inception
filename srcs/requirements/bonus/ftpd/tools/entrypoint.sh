#!/bin/sh

FTP_USER=${FTP_USER:?}
FTP_PASSWORD=${FTP_PASSWORD:?}

if ! id "$FTP_USER" &>/dev/null; then
    adduser -D -h /var/www/html "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

if [ -n "$PUBLICHOST" ]; then
  echo "$PUBLICHOST" > /etc/pure-ftpd/conf/ForcePassiveIP
fi

exec "$@"
