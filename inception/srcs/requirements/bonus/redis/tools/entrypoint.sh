#!/usr/bin/env sh

if [ ! -d /etc/redis/ ]; then
	echo "Setting up redis"
	mkdir -p /etc/redis
	envsubst '${REDIS_HOST} ${REDIS_PASSWORD}' < /tmp/redis.conf.template > /etc/redis/redis.conf
	
	redis-server /etc/redis/redis.conf
	
	echo "Check redis server activated..."
	for i in `seq 1 10`; do
		RET=`echo "PING" | redis-cli -h ${REDIS_HOST} -a ${REDIS_PASSWORD}`
		if [ RET = "PONG" ]; then
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
	
	redis-cli -h ${REDIS_HOST} -a ${REDIS_PASSWORD} shutdown
	echo "Shutdonw redis server..."
else
	echo "redis already setup"
fi

echo "Execute $@"
exec "$@"