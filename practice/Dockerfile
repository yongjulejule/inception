FROM ubuntu
COPY index.html /usr/share/nginx/html/index.html
COPY a.out /a.out
EXPOSE 80/udp
ENV LINK=ZELDA
RUN echo "$LINK" > hi
#ENTRYPOINT /a.out
RUN mkdir /myvol
RUN echo "hello world" > /myvol/hihi
VOLUME /myvol
STOPSIGNAL SIGSTOP

