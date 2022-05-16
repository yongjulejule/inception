FROM alpine:3.14

RUN apk update && \
	apk add --no-cache mariadb mariadb-client

COPY script.sh /script.sh

EXPOSE 3306

ENTRYPOINT ["/bin/sh", "/script.sh"]

# VOLUME ["/var/lib/mysql"]
