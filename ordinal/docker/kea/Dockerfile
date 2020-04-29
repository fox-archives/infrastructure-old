FROM debian:stretch-slim

ENV keaVersion="1.6.2"

RUN apt-get -y update && \
  apt-get -y install curl make automake gcc g++ pkg-config \
  libtool libbotan1.10-dev liblog4cplus-dev libboost1.62-all-dev

RUN cd /usr/local/src && \
  curl -OL https://downloads.isc.org/isc/kea/${keaVersion}/kea-${keaVersion}.tar.gz && \
  tar -zxf kea-${keaVersion}.tar.gz && \
  rm kea-${keaVersion}.tar.gz

RUN cd /usr/local/src/kea-${keaVersion} && \
  ./configure --prefix=/usr/local --enable-shell \
  --with-site-packages=/usr/lib/python3/dist-packages && \
  make && \
  make install && \
  apt-get -y autoremove
