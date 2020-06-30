FROM debian:buster-slim

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl git \
    build-essential cmake ninja-build clang gcc-arm-none-eabi srecord \
    python3 python3-dev \
    python3-pip python3-setuptools python3-usb \
    libffi-dev libssl-dev libxml2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U yotta

RUN mkdir /yotta
WORKDIR /yotta
