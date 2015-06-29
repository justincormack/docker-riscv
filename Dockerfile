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

RUN \
  mkdir -p /usr/src && cd /usr/src && \
    git clone https://github.com/lowRISC/riscv-tools.git && \
    cd riscv-tools && git submodule update --init --recursive

WORKDIR /usr/src/riscv-tools

ENV RISCV=/usr/local

RUN \
  ./build.sh
