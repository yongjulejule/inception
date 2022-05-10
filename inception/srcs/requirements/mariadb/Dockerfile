FROM alpine:3.13

RUN apk update &&\
    apk add mariadb mariadb-client

RUN apk add openrc && mkdir -p /run/openrc && touch /run/openrc/softlevel

RUN /etc/init.d/mariadb setup
