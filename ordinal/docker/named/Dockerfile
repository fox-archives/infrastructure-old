FROM debian:stretch-slim

ENV bindVersion="9.16.2"

RUN apt-get update && \
  apt-get -y install curl make automake gcc g++ pkg-config \
  libtool python3-ply libuv1-dev libjson-c-dev libcap-dev \
  zlibc libxml2-dev

RUN cd /usr/local/src && \
  curl -OL https://downloads.isc.org/isc/bind9/${bindVersion}/bind-${bindVersion}.tar.xz && \
  tar -Jxf bind-${bindVersion}.tar.xz

RUN cd /usr/local/src/bind-${bindVersion} && \
  ./configure --prefix=/usr/local --with-json-c \
  --with-zlib --with-libxml2 && \
  make && \
  make install && \
  apt-get -y autoremove
