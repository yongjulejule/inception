ARG TAG=latest
FROM --platform=linux/arm64 nginx:${TAG} AS nginginx
COPY index.html /usr/share/nginx/html/index.html
RUN touch abc
ARG TAG=bb
RUN touch ${TAG}a
