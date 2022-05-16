FROM alpine:3.14

RUN apk update &&\
	apk add --no-cache mariadb mariadb-client

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

