FROM ubuntu:xenial

# Get needed packages
RUN set -x \
  && buildDeps=' \
      ca-certificates \
      cmake \
      g++ \
      git \
      libboost-all-dev \
      libssl-dev \
      make \
      pkg-config \
      build-essential \
      libzmq3-dev \
      libreadline-dev \
      libsodium-dev \
      wget \
      libgtest-dev \
      libevent-dev \
      libunbound-dev \
      libminiupnpc-dev \
      libunwind8-dev \
      libldns-dev \
      libexpat1-dev \
      libdb-dev \
      graphviz \
      doxygen \
  ' \
  && apt-get -qq update \
  && apt-get -qq install $buildDeps


# Create app directory
RUN mkdir -p /daemon && mkdir -p /daemon/data && mkdir -p /daemon

WORKDIR /usr/src/gtest
RUN cmake . && make && mv libg* /usr/lib/

# Install Daemon
WORKDIR /daemon/
RUN git clone https://github.com/sumoproject/sumokoin.git src
WORKDIR /daemon/src/
RUN make -j$(nproc) release-static

RUN mv /daemon/src/build/release/bin/* /daemon && rm -rf /daemon/src
WORKDIR /daemon/

EXPOSE  18081 18082