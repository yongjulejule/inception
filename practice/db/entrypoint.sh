#!/bin/sh

set -ex

if [ -d "/run/mysqld" ]; then
	chown -R mysql:mysql /run/mysqld
else
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	chown -R mysql:mysql /var/lib/mysql
else

	echo "Creating initial Mysql databases"

	MYSQL_DATABASE=${MYSQL_DATABASE:-"42-default-db"}
	MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"root"}
	MYSQL_USER=${MYSQL_USER:-"42-user"}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-"4242"}

	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
	
	if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
		echo "MYSQL_ROOT_PASSWORD environment variable not exist" >&2
	fi


	tmpfile=`mktemp`

	cat << EOF > $tmpfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

	if [ "$MYSQL_DATABASE" != "" ]; then

		MYSQL_CHARSET=${MYSQL_CHARSET:-utf8}
		MYSQL_COLLATION=${MYSQL_COLLATION:-utf8_general_ci}

		echo "Creating database: $MYSQL_DATABASE"
		echo "with character set [$MYSQL_CHARSET] and collation [$MYSQL_COLLATION]"
		echo "CREATE DATABASES IF NOT EXISTS '$MYSQL_DATABASE' CHARACTER SET ${MYSQL_CHARSET} COLLATE $MYSQL_COLLATION;" >> $tmpfile

		if [ "$MYSQL_USER" != "" ]; then
			echo "Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
			echo "GRANT ALL ON '$MYSQL_DATABASE'.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tmpfile
		fi
	fi

	echo
	cat $tmpfile
	echo

	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tmpfile
	rm -f $tmpfile

	echo "Mariadb init process done."

fi

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@