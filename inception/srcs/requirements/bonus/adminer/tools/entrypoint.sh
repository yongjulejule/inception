#!/usr/bin/env sh

set -x

mkdir -p /var/www
mkdir -p /var/www/html
mkdir -p /var/www/html/wordpress
mkdir -p /var/www/html/wordpress/adminer/
cp /tmp/adminer.php /var/www/html/wordpress/adminer/adminer.php
chown -R www-data:www-data /var/www/html

exec "$@"