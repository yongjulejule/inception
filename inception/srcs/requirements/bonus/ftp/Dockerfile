FROM alpine:3.14

RUN set -ex && \
	apk update && apk add tini

RUN set -ex && \
	apk update && \
	apk add vsftpd 
#&& \
# ln -sf /dev/stderr /var/log/vsftpd.log

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 21

COPY conf/vsftpd.conf /tmp/vsftpd.conf

ENTRYPOINT [ "/sbin/tini", "--", "/tmp/entrypoint.sh" ]

VOLUME [ "/var/www/ftp" ]

# FIXME
CMD [ "vsftpd" ]