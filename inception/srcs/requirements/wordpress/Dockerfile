FROM alpine:3.14

RUN set -ex && \
	apk update && \
	apk add --no-cache tini

RUN adduser -D -S -H -u 82 -G www-data www-data

RUN set -ex && \
	apk update && \
	apk add curl mariadb-client redis php7 php7-phar php7-common php7-fpm php7-iconv php7-json php7-mysqli php7-session && \
	mkdir -p /var/log/php7 && \
	touch /var/log/php7/access.log && \
	ln -sf /dev/stderr /var/log/php7/error.log && \
	chown -R www-data:www-data /var/log/php7

RUN set -ex && \
	curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /usr/local/bin/wp; \
	echo "path: /var/www/html/wordpress" > wp-cli.yml

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

COPY conf/wp-config.php /tmp/wp-config.php

EXPOSE 9000

ENTRYPOINT [ "/sbin/tini", "--", "/tmp/entrypoint.sh" ]

CMD [ "php-fpm7", "-F"]