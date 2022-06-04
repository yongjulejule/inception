#!/usr/bin/env sh

set -e

if [ ! -f /var/www/html/index.html ]; then
	mkdir -p /var/www/html/inception
	cp /tmp/index.html /var/www/html/inception/index.html
	cp /tmp/conf.template /etc/nginx/conf.d/default.conf
	sed -i s/"user  nginx"/"user  www-data"/ /etc/nginx/nginx.conf
	chown -R www-data:www-data /var/log/nginx
fi

set +e
nginx -t >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "nginx does not work... please check configure!" >&2
	exit 1
fi

echo "Executing $@"
exec "$@"