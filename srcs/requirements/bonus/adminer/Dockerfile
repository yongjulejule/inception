FROM alpine:3.14

RUN set -ex && \
	apk update && \
	apk add --no-cache tini

RUN adduser -D -S -H -u 82 -G www-data www-data

RUN set -ex && \
	apk update && \
	apk add curl php7 php7-common php7-fpm php7-iconv php7-json php7-mysqli php7-session

RUN curl -L -o /tmp/adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

EXPOSE 8000

ENTRYPOINT [ "/sbin/tini", "--", "/tmp/entrypoint.sh" ]

CMD [ "php-fpm7", "-F"]