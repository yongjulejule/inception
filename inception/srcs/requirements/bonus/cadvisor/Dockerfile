FROM alpine:3.14

RUN set -ex && \
	apk update && \
	apk add --no-cache tini

RUN adduser -D -S --home /var/cache/nginx -u 82 -G www-data www-data

RUN apk add --no-cache libc6-compat && \
	wget https://github.com/google/cadvisor/releases/download/v0.39.3/cadvisor && \
	chmod +x cadvisor && \
	chown www-data:www-data cadvisor && \
	mv cadvisor /usr/local/bin/

EXPOSE 8080

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "/sbin/tini", "--", "/usr/local/bin/cadvisor" ]