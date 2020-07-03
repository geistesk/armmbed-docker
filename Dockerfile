FROM debian:buster-slim

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl git mercurial \
    build-essential cmake ninja-build clang srecord \
    binutils-arm-none-eabi crossbuild-essential-armhf gcc-arm-none-eabi \
    python3 python3-dev python3-pip python3-setuptools python3-usb \
    libffi-dev libssl-dev libxml2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

RUN pip3 install -U mbed-cli==1.10.4 yotta

RUN cd /usr/local/lib/python3.7/dist-packages/mbed \
  && curl -o /tmp/mbed-py3.patch https://patch-diff.githubusercontent.com/raw/ARMmbed/mbed-cli/pull/969.patch \
  && patch < /tmp/mbed-py3.patch \
  && rm /tmp/mbed-py3.patch

RUN mkdir /root/bin \
  && echo "#!/usr/bin/env bash" > /root/bin/cmake \
  && echo "/usr/bin/cmake -DCMAKE_C_COMPILER_WORKS=TRUE \$@" >> /root/bin/cmake \
  && chmod +x /root/bin/cmake
ENV PATH="/root/bin:${PATH}"

RUN cd /tmp && mbed new test && cd test \
  && pip3 install -r mbed-os/requirements.txt \
  && mbed compile >/dev/null 2>&1; cd /tmp \
  && rm -r /tmp/test \
  && mbed config --global toolchain gcc_arm

RUN mkdir /app
WORKDIR /app
