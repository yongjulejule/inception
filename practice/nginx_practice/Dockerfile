FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
ENV LINK=ZELDA
RUN echo "$LINK" > hi
#ENTRYPOINT /a.out
STOPSIGNAL SIGINT

