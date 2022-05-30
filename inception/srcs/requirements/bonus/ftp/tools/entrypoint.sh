#!/usr/bin/env sh

set -x

cp /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf
chown -R vsftp:ftp /var/www
mkdir /home/vsftp && chown -R vsftp:ftp /home/vsftp

echo "Execute $@"
exec "$@"