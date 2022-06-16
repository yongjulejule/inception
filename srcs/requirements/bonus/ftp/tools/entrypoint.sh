#!/usr/bin/env sh

set -e

if [ ! -f .setup ]; then
	echo "Setting up vsftpd"
	cp /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf
	chown -R www-data:www-data /var/www/wordpress
	echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | passwd www-data
	touch .setup
else
	echo "vsftpd is already setup"
fi

echo "Execute $@"
exec "$@"