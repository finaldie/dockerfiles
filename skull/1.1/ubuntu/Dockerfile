# Based on ubuntu 16.04 image
FROM ubuntu:16.04

# Install all the dependencies
RUN set -ex \
    && apt-get update && apt-get install -y --no-install-recommends \
        psmisc \
        netcat-openbsd \
        net-tools \
        vim \
        make \
        gcc \
        g++ \
        gdb \
        valgrind \
        expect \
        libyaml-dev \
        python-dev \
        python-pip \
        libprotobuf-dev \
        protobuf-compiler \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade setuptools pip \
    && pip install \
        PyYAML \
        protobuf==2.6.1 \
        pympler \
        WebOb

# Build and Install Skull
RUN deps='git autoconf libprotobuf-c0-dev protobuf-c-compiler' \
    && set -ex \
    # Install temp building tool-chains
    && apt-get update && apt-get install -y --no-install-recommends $deps \
    && rm -rf /var/lib/apt/lists/* \
    # Clone branch 1.1
    && git clone --single-branch --branch 1.1 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    # Build and Install
    && make -C /build \
    && make -C /build install \
    # Verification
    && make -C /build check verbose=true \
    # Cleanup
    && rm -rf /build \
    && apt-get purge -y --auto-remove $deps

# Setup environment variables
ENV SKULL_VERSION 1.1
ENV SKULL_GITSHA1 9414527e75b4cdf2dce83f8905058d04ddd529b1

VOLUME /workspace
WORKDIR /workspace

# Entrypoint
CMD ["/bin/bash"]

