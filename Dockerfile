FROM ubuntu:20.04

# Basic setup
RUN \
  rm /bin/sh && \
  ln -s /bin/bash /bin/sh && \
  apt-get update -y && \
  apt-get install wget -y && \
  apt-get install tzdata -y

# Install cockroachdb
RUN \
  wget https://binaries.cockroachdb.com/cockroach-v20.2.1.linux-amd64.tgz && \
  tar -xvzf cockroach-v20.2.1.linux-amd64.tgz && \
  cp cockroach-*/cockroach /usr/local/bin/

# Install openssl
RUN \
  apt-get install build-essential checkinstall zlib1g-dev -y && \
  cd /usr/local/src/ && \
  wget https://www.openssl.org/source/openssl-1.1.1h.tar.gz && \
  tar -xf openssl-1.1.1h.tar.gz && \
  cd openssl-1.1.1h && \
  ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && \
  make && \
  make install && \
  echo "/usr/local/ssl/lib" > /etc/ld.so.conf.d/openssl-1.1.1h.conf && \
  ldconfig -v && \
  echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/ssl/bin"' > /etc/environment && \
  source /etc/environment
