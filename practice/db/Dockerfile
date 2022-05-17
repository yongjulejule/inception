FROM alpine:3.14

# install tini for PID 1
RUN set -eux; \
	apk update; \
	apk add --no-cache tini

# install mariadb
RUN set -ex; \
	apk update; \
	apk add --no-cache mariadb mariadb-client; \
	mkdir -p /run/mysqld /var/lib/mysql; \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql;

COPY entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/tmp/entrypoint.sh", "mariadb"]

# VOLUME ["/var/lib/mysql"]