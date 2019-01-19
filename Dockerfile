FROM ubuntu:18.04

RUN \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install \
    git \
    autoconf \
    automake \
    autotools-dev \
    curl \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev \
    libusb-1.0-0-dev \
    gawk \
    build-essential \
    bison \
    flex \
    texinfo \
    gperf \
    libtool \
    patchutils \
    bc \
    zlib1g-dev \
    device-tree-compiler \
    pkg-config \
    libexpat-dev \
    vim \
    libncurses5-dev \
    gperf

# clone repo
RUN \
  mkdir -p /usr/src && cd /usr/src && \
    git clone https://github.com/riscv/riscv-tools.git && \
    cd riscv-tools && git submodule update --init --recursive

WORKDIR /usr/src/riscv-tools

ENV RISCV=/usr/local

# build
RUN \
  ./build.sh

# quick hello world test
COPY hello.c /usr/src/
RUN \
  riscv64-unknown-elf-gcc -o /usr/src/hello /usr/src/hello.c && \
  spike pk /usr/src/hello && \
  rm /usr/src/hello /usr/src/hello.c
