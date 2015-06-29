FROM ubuntu:15.04

MAINTAINER Justin Cormack <justin@specialbusservice.com>

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
    gawk \
    build-essential \
    bison \
    flex \
    texinfo \
    gperf

# clone repo
RUN \
  mkdir -p /usr/src && cd /usr/src && \
    git clone https://github.com/lowRISC/riscv-tools.git && \
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
  spike pk /usr/src/hello
