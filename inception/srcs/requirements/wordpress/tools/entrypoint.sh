#!/usr/bin/env sh

mkdir -p ${HOME}/var/www/wordpress
wp core download --path=${HOME}/var/www/wordpress
cp /tmp/wp-config.php ${HOME}/var/www/wordpress/wp-config.php && rm ${HOME}/var/www/wordpress/wp-config-sample.php


exec "$@"
