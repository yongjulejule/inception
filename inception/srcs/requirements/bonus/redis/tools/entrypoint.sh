#!/usr/bin/env sh

set -e

if [ ! -d /etc/redis/ ]; then
	echo "Setting up redis"
	mkdir -p /etc/redis
	envsubst '${REDIS_HOST} ${REDIS_PASSWORD}' < /tmp/redis.conf.template > /etc/redis/redis.conf

	redis-server /etc/redis/redis.conf &

	set +e
	echo "Check redis server activated..."
	for i in `seq 1 10`; do
		RET=`echo "PING" | redis-cli -h ${REDIS_HOST} -a ${REDIS_PASSWORD}` 2>/dev/null
		if [ $RET = "PONG" ]; then
			echo "Redis server is active!"
			break
		fi
		echo "Redis server is not active yet $i/10..."
		if [ $i -eq 10 ]; then
			echo "Fail to connect redis client." >&2
			exit 1
		fi
		sleep 1
	done

	set -e
	echo "Shutdown redis server..."
	redis-cli -h ${REDIS_HOST} -a ${REDIS_PASSWORD} shutdown 2>/dev/null
	echo "redis init process done."
	tail -f /var/log/redis/redis.log &
else
	echo "redis already setup."
fi

echo "Execute $@"
exec "$@"