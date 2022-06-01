#!/usr/bin/env sh

set -e

if [ ! -f .setup ]; then
	echo "Setting up Nginx"
	envsubst '${DOMAIN_NAME}' < /tmp/conf.template > /etc/nginx/conf.d/default.conf
	openssl req -new -newkey rsa:2048 -nodes -keyout \
	/etc/nginx/${DOMAIN_NAME}.key -out \
	/etc/nginx/${DOMAIN_NAME}.csr -subj \
	"/C=KR/ST=Seoul/L=gae-po/O=SecureSignKR/OU=42-Seoul/CN=${DOMAIN_NAME}"
	openssl x509 -req -days 365 -in /etc/nginx/${DOMAIN_NAME}.csr \
	-signkey /etc/nginx/${DOMAIN_NAME}.key \
	-out /etc/nginx/${DOMAIN_NAME}.crt
	sed -i s/"user  nginx"/"user  www-data"/ /etc/nginx/nginx.conf
	chown -R www-data:www-data /var/log/nginx
	touch .setup
else
	echo "Nginx is already setup"
fi

set +e
nginx -t >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "nginx does not work... please check configure!" >&2
	exit 1
fi

echo "Executing $@"
exec "$@"
