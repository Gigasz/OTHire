FROM alpine:latest

COPY . /otserv/.

RUN echo http://mirror.yandex.ru/mirrors/alpine/v3.5/main > /etc/apk/repositories; \
    echo http://mirror.yandex.ru/mirrors/alpine/v3.5/community >> /etc/apk/repositories

# RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
RUN apk update && \
    apk upgrade && \
    apk add --no-cache autoconf build-base pkgconfig boost-dev gmp-dev libxml2-dev && \
    apk add --no-cache automake lua lua-dev mariadb-dev crypto++ ccache \
    cd /otserv/source && \
    chmod +x autogen.sh && \
    ./autogen.sh && \
    ./configure --enable-mysql --enable-server-diag && \
    make
