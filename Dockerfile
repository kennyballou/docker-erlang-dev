# DOCKER-VERSION 1.9.1
FROM kennyballou/docker-erlang:18.3.3
MAINTAINER kballou@devnulllabs.io

RUN apk update && apk add \
    autoconf \
    gcc \
    m4 \
    make \
    musl-dev \
    perl \
    tar
