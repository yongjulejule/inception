FROM alpine:3.14

RUN set -ex && \
	apk update && \
	apk add --no-cache tini

RUN set -ex; \
	apk update && \
	apk add --no-cache mariadb mariadb-client && \
	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld /usr/lib/mariadb && \
	chmod 777 /usr/lib/mariadb;

COPY tools/entrypoint.sh /tmp/entrypoint.sh

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/sbin/tini", "--", "/tmp/entrypoint.sh"]

CMD ["/usr/bin/mysqld"]

