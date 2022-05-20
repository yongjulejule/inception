#!/usr/bin/env sh

set -x

cat /etc/my.cnf.d/mariadb-server.cnf
echo "Creating initial Mysql databases"

MYSQL_DATABASE=${MYSQL_DATABASE:-"42defaultdb"}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"rmfnxm"}
MYSQL_USER=${MYSQL_USER:-"42user"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"4242"}

# mysql_install_db --datadir=/var/lib/mysql --auth-root-authentication-method=normal
# Make temporary file to save query
tmpfile=`mktemp`
echo `id`

# Create Query
cat << EOF > $tmpfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

# Create Database
	MYSQL_CHARSET=${MYSQL_CHARSET:-utf8}
	MYSQL_COLLATION=${MYSQL_COLLATION:-utf8_general_ci}

# FIXME : Setting character set and collation for mysql database. THis should be done in the other way around.
echo "Creating database: $MYSQL_DATABASE"
echo "with character set [$MYSQL_CHARSET] and collation [$MYSQL_COLLATION]"
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET ${MYSQL_CHARSET} COLLATE $MYSQL_COLLATION;" >> $tmpfile

echo "Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tmpfile

# FIXME: Delete... For debugging
cat $tmpfile

/usr/bin/mysqld_safe --datadir='/var/lib/mysql' &

sleep 3
mysqladmin ping
# FIXME: DONT WOKR HERE!!!!!!!! NO PERMOSSION
mariadb < $tmpfile
echo $?
sleep 1

for i in `seq 1 30`; do
	sleep 1
	echo $i
	echo "for loop until mysql set up"
	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD ping
	RET=$?
	if [ $RET -eq 0 ]; then
		break
	fi
	echo 'MySQL init process in progress...'
done

echo "shutdown..."
mysqladmin shutdown

echo "Mariadb init process done."

echo "exec /usr/bin/mysqld_safe --datadir=/var/lib/mysql"
rm -f $tmpfile
exec "$@"
