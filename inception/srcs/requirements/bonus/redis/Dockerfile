FROM alpine:3.14

RUN set -ex && \
	apk update && apk add tini

RUN adduser -D -S -H -u 82 -G www-data www-data

# install redis
RUN set -ex && \
	apk update && apk add redis gettext

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 6379

COPY conf/redis.conf.template /tmp/redis.conf.template

ENTRYPOINT [ "/sbin/tini", "--", "/tmp/entrypoint.sh" ]

CMD [ "redis-server", "/etc/redis/redis.conf"]