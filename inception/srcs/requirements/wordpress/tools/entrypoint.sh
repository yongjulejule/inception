#!/usr/bin/env sh

cp /tmp/wp-config.php /var/www/html/wordpress/
chown -R nginx:nginx /var/www/html


exec "$@"
