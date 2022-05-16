FROM alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80/udp
ENV LINK=ZELDA
RUN echo "$LINK" > hi
#ENTRYPOINT /a.out
RUN mkdir /myvol
RUN echo "hello world" > /myvol/hihi
RUN adduser -D -G root ${user:-link}
USER ${user:-link}
RUN id > ~/id_link
ARG user
USER root
RUN adduser -D -G root $user
USER $user
RUN id > ~/id_yongjule
VOLUME /myvol
STOPSIGNAL SIGSTOP

