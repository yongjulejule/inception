#!/usr/bin/env sh

set -e

if [ ! -d /var/lib/mysql/$MYSQL_DATABASE ]; then

	touch /var/lib/mysql/mariadb_error.log
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --auth-root-authentication-method=normal

	echo "Creating initial MaraiDB databases"

	MYSQL_DATABASE=${MYSQL_DATABASE}
	MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
	MYSQL_USER=${MYSQL_USER}
	MYSQL_PASSWORD=${MYSQL_PASSWORD}

	# Make temporary file to save query
	tmpfile=`mktemp`

	# Create Query
	cat << EOF > $tmpfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

	# Create Database
	MYSQL_CHARSET=${MYSQL_CHARSET:-utf8}
	MYSQL_COLLATION=${MYSQL_COLLATION:-utf8_general_ci}

	echo "Creating database: $MYSQL_DATABASE"
	echo "with character set [$MYSQL_CHARSET] and collation [$MYSQL_COLLATION]"
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET ${MYSQL_CHARSET} COLLATE $MYSQL_COLLATION;" >> $tmpfile

	echo "Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
	echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tmpfile
	echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tmpfile

	set +e
	# Run MariaDB Server as background
	/usr/bin/mysqld_safe &

	# Check MariaDB server started.
	echo "for loop until MariaDB server set up"
	for i in `seq 1 30`; do
		mysqladmin ping > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			echo "MariaDB server started!"
			break
		fi
		echo "MariaDB server does not started yet $i/30..."
		if [ $i -eq 30 ]; then
			echo "MariaDB server start failed!" >&2
			exit 1
		fi
		sleep 1
	done

	# Run query 
	mariadb < $tmpfile
	if [ $? -ne 0 ]; then
		echo "The root already exist. Login as root..."
		mariadb -uroot -p${MYSQL_ROOT_PASSWORD} <$tmpfile
	fi
	rm -f $tmpfile

	set -e
	echo "shutdown..."
	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

	echo "MariaDB init process done."
else
	echo "Database already installed."
fi

echo "Execute $@"
exec "$@"
