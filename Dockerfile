# DOCKER-VERSION 1.9.1
FROM alpine:3.3
MAINTAINER kballou@devnulllabs.io

ENV LANG="en_US.UTF-8"
ENV OTP_VER=18.3.2

RUN apk update && apk add \
    autoconf \
    bash \
    curl \
    gcc \
    libedit \
    m4 \
    make \
    musl-dev \
    ncurses-dev \
    ncurses-libs \
    ncurses-terminfo \
    ncurses-terminfo-base \
    openssl-dev \
    openssl \
    perl \
    tar \
    unixodbc-dev

RUN set -xe \
    && OTP_SRC_URL="https://github.com/erlang/otp/archive/OTP-$OTP_VER.tar.gz" \
    && curl -fSL "$OTP_SRC_URL" -o otp-src.tar.gz \
    && mkdir -p /usr/src/otp-src \
    && tar -zxf otp-src.tar.gz -C /usr/src/otp-src --strip-components=1 \
    && cd /usr/src/otp-src \
    && ./otp_build autoconf \
    && ./configure \
    && make -j 4 \
    && make install \
    && find /usr/local -name examples | xargs rm -rf

CMD ["erl"]

ENV REBAR_VERSION="2.6.1"

RUN set -xe \
    && REBAR_SRC_URL="https://github.com/rebar/rebar/archive/${REBAR_VERSION##*@}.tar.gz" \
    && mkdir -p /usr/src/rebar-src \
    && curl -fSL "$REBAR_SRC_URL" -o rebar-src.tar.gz \
    && tar -zxf rebar-src.tar.gz -C /usr/src/rebar-src --strip-components=1 \
    && rm rebar-src.tar.gz \
    && cd /usr/src/rebar-src \
    && ./bootstrap \
    && install -v ./rebar /usr/local/bin \
    && rm -rf /usr/src/rebar-src

ENV REBAR3_VERSION="3.1.0"

RUN set -xe \
    && REBAR3_SRC_URL="https://github.com/erlang/rebar3/archive/${REBAR3_VERSION##*@}.tar.gz" \
    && mkdir -p /usr/src/rebar3-src \
    && curl -fSL "$REBAR3_SRC_URL" -o rebar3-src.tar.gz \
    && tar -zxf rebar3-src.tar.gz -C /usr/src/rebar3-src --strip-components=1 \
    && rm rebar3-src.tar.gz \
    && cd /usr/src/rebar3-src \
    && HOME=$PWD ./bootstrap \
    && install -v ./rebar3 /usr/local/bin \
    && rm -rf /usr/src/rebar3-src

RUN apk del \
    bash \
    curl \
    unixodbc-dev