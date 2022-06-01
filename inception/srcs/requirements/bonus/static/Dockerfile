FROM alpine:3.14

RUN set -ex \
	apk update && apk add tini

RUN adduser -D -S --home /var/cache/nginx -u 82 -G www-data www-data

RUN set -ex \
	apk update && \
	# install prerequsitions
	apk add  --no-cache openssl curl ca-certificates && \
	# install nginx
	printf "%s%s%s%s\n" \
	"@nginx " \
	"http://nginx.org/packages/alpine/v" \
	`egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
	"/main" \
	| tee -a /etc/apk/repositories && \
	curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub && \
	openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout && \
	mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/ && \
	apk update && apk add nginx@nginx && \
	touch /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

COPY tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
COPY conf/conf.template /tmp/conf.template
COPY tools/index.html /tmp/index.html

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "/sbin/tini", "--", "/tmp/entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]
