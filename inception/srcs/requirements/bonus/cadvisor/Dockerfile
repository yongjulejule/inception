FROM alpine:3.14

RUN apk update && apk add tini

RUN apk add --no-cache libc6-compat && \
	wget https://github.com/google/cadvisor/releases/download/v0.39.3/cadvisor && \
	chmod +x cadvisor && \
	chmod +x cadvisor && \
	mv cadvisor /usr/local/bin/

EXPOSE 8080

ENTRYPOINT [ "/sbin/tini", "--", "/usr/local/bin/cadvisor" ]
