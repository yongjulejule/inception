FROM alpine:3.14

RUN set -ex \
	apk update && apk add tini

RUN addgroup -g 101 -S nginx \
	&& adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

RUN set -ex \
	apk update && \
	apk add lighttpd mariadb-client php7-common php7-session php7-iconv php7-json \
	php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo \
	php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext \
	php7-ldap php7-ctype php7-dom php7-simplexml php7-fpm

RUN mkdir -p /var/www/html /usr/log/php7/ && \
	touch /usr/log/php7/www.access.log&& \
	cd /var/www/html && \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz >/dev/null && \
	rm latest.tar.gz && \
	chown  -R nginx /var/www/html/wordpress && \
	ln -s /var/www/html/wordpress/ /var/www/localhost/htdocs/wordpress

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

COPY conf/www.conf /etc/php7/php-fpm.d/www.conf
COPY --chown=nginx:nginx conf/wp-config.php /tmp/wp-config.php
RUN rm /var/www/html/wordpress/wp-config-sample.php

ENTRYPOINT [ "/sbin/tini", "--", "/tmp/entrypoint.sh" ]

CMD [ "php-fpm7", "-F"]