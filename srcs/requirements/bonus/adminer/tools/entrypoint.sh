#!/usr/bin/env sh

set -e

if [ ! -f /var/www/html/index.php ]; then
	mkdir -p /var/www
	mkdir -p /var/www/html
	cp /tmp/adminer.php /var/www/html/index.php
	chown -R www-data:www-data /var/www/html
fi

exec "$@"