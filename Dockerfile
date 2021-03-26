FROM alpine:latest

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
 apk add --no-cache mongodb-tools mysql-client postgresql-client redis curl git
