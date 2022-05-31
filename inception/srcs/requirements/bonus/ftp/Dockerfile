FROM alpine:3.14

RUN set -ex && \
	apk update && \
	apk add tini

RUN adduser -D -S --home /var/www/wordpress -u 82 -G www-data www-data && addgroup www-data ftp

RUN set -ex \
	apk update && \
	apk add --no-cache vsftpd

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 21

COPY conf/vsftpd.conf /tmp/vsftpd.conf

ENTRYPOINT [ "/sbin/tini", "--", "/tmp/entrypoint.sh" ]

VOLUME [ "/var/www/ftp" ]

# FIXME
CMD [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]