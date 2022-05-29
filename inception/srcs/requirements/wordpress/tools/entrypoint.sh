#!/usr/bin/env sh

set -x

# Errors here
if [ ! -d /var/www/html/wordpress/ ]; then
	echo "Download wordpress..."
	mkdir -p /var/www/html/
	wp core download --allow-root
	cp /tmp/wp-config.php /var/www/html/wordpress/wp-config.php
fi

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
	echo "Install Wordpress"
	wp core install --allow-root \
	--url=${DOMAIN_NAME} --title="incepcepcepception" \
	--admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASSWORD} \
	--admin_email=${WP_ADMIN_EMAIL} --skip-email

	wp user create --allow-root \
  ${WP_USER_NAME} ${WP_USER_EMAIL} --role=editor --user_pass=${WP_USER_PASSWORD}

	RET=`echo "PING" | redis-cli -h ${REDIS_HOST} -a ${REDIS_PASSWORD}`

	if [ RET == "PONG" ]; then
		echo "Redis server is active!"
	else
		echo "Fail to connect redis client." >&2
		exit 1
	fi

	echo "Install redis-cache for wordpress"
	wp plugin install --allow-root \
	redis-cache
	wp plugin activate --allow-root \
	redis-cache
	wp redis enable --force --allow-root
else
	echo "wordpress is already installed."
fi

chown -R www-data:www-data /var/www/html

echo "Execute $@"
exec "$@"
