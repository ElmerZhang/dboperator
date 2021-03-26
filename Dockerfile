FROM golang:alpine as builder
WORKDIR /go/src/github.com/aliyun/
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk add --update make git; \
    git clone https://github.com/aliyun/aliyun-cli.git; \
    git clone https://github.com/aliyun/aliyun-openapi-meta.git
WORKDIR /go/src/github.com/aliyun/aliyun-cli
ENV GOPROXY=https://goproxy.cn
RUN make deps; \
    make testdeps; \
    make build;

FROM alpine:latest

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
 apk add --no-cache mongodb-tools mysql-client postgresql-client redis curl git

COPY --from=builder /go/src/github.com/aliyun/aliyun-cli/out/aliyun /usr/local/bin
