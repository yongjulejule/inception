FROM alpine:3.14

# install tini for PID 1
RUN set -eux; \
	apk update; \
	apk add --no-cache tini

# install mariadb
RUN set -ex; \
	apk update; \
	# install mariadb
	apk add --no-cache mariadb mariadb-client; \
	# make directory if not exist
	mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /usr/lib/mariadb && chmod 777 /usr/lib/mariadb;
# set install db in specified directory
# mysql_install_db --user=mysql --datadir='/var/lib/mysql' && chown -R mysql:mysql /var/lib/mysql;

COPY tools/entrypoint.sh /tmp/entrypoint.sh

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

STOPSIGNAL SIGQUIT

# init by tini for PID 1
ENTRYPOINT ["/sbin/tini", "--", "/tmp/entrypoint.sh"]

CMD ["/usr/bin/mysqld_safe"]

