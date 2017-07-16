# Based on ubuntu 16.04 image
# FROM ubuntu:16.04

# Based on debian stable image
# FROM debian:stretch-slim

# Based on alpine
FROM alpine:3.6

# Install all the dependencies
RUN set -ex \
    && apt-get update && apt-get install -y --no-install-recommends \
        psmisc \
        netcat-openbsd \
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
    # Clone latest master
    #&& mkdir /build \
    && git clone git://github.com/finaldie/skull.git /build --recursive \
    # Build and Install
    && make -C /build dep \
    && make -C /build install-dep \
    && make -C /build \
    && make -C /build install \
    # Verification
    && make -C /build check case=basic,py_basic debug=true \
    # Cleanup
    && rm -rf /build \
    && apt-get purge -y --auto-remove $deps

# Setup environment variables
# ENV key value

VOLUME /workspace
WORKDIR /workspace

# Entrypoint
CMD ["/bin/bash"]

