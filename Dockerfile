# DOCKER-VERSION 1.9.1
FROM kennyballou/docker-erlang
MAINTAINER kballou@devnulllabs.io

RUN apk update && apk add \
    autoconf \
    gcc \
    m4 \
    make \
    musl-dev \
    perl \
    tar
