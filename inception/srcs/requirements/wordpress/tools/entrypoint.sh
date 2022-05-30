#!/usr/bin/env sh

set -e

if [ ! -d /var/www/html/wordpress/ ]; then
	echo "Download wordpress..."
	mkdir -p /var/www/html/
	wp core download --allow-root
	cp /tmp/wp-config.php /var/www/html/wordpress/wp-config.php
fi

set +e

echo "Check DB server alive"
for i in `seq 1 30`; do
	mysqladmin ping -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_HOST} >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "MariaDB server in Wordpress container started!"
		break
	fi
	echo "MariaDB server in Wordpress container does not started yet $i/30..."
	if [ $i -eq 30 ]; then
		echo "MariaDB server in Wordpress container start failed!" >&2
		exit 1
	fi
	sleep 1
done

if ! wp core is-installed --allow-root; then
	set -e
	echo "Install Wordpress"
	wp core install --allow-root \
	--url=${DOMAIN_NAME} --title="incepcepcepception" \
	--admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASSWORD} \
	--admin_email=${WP_ADMIN_EMAIL} --skip-email

	wp user create --allow-root \
  ${WP_USER_NAME} ${WP_USER_EMAIL} --role=editor --user_pass=${WP_USER_PASSWORD}
	set +e
else
	echo "wordpress is already installed."
fi

if ! wp plugin is-installed redis-cache --allow-root; then
	RET=`echo "PING" | redis-cli -h ${REDIS_HOST} -a ${REDIS_PASSWORD}` 2>/dev/null

	if [ $RET = "PONG" ]; then
		echo "Redis server is active!"
	else
		echo "Fail to connect redis client." >&2
		exit 1
	fi

	set -e
	echo "Install redis-cache for wordpress"
	wp plugin install --allow-root \
	redis-cache
	wp plugin activate --allow-root \
	redis-cache
	wp redis enable --force --allow-root
fi

chown -R www-data:www-data /var/www/html

echo "Execute $@"
exec "$@"
