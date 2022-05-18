FROM alpine:3.14

# install tini for PID 1
RUN set -eux; \
	apk update; \
	apk add --no-cache tini

# install mariadb
# 디렉토리를 생성해주지 않으면 작동하지 않음.
RUN set -ex; \
	apk update; \
	apk add --no-cache mariadb mariadb-client; \
	mkdir -p /run/mysqld; \
	chown -R mysql:mysql /run/mysqld;

COPY entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

# init by tini for PID 1
ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/tmp/entrypoint.sh"]

# VOLUME ["/var/lib/mysql"]