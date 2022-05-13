FROM alpine:3.13
COPY index.html /usr/share/nginx/html/index.html
COPY a.out /
EXPOSE 80/udp
ENV LINK=ZELDA
RUN echo "$LINK" > hi
ADD --chown=non:exist test /
