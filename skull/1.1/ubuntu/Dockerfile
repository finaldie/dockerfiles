# Based on ubuntu 16.04 image
FROM ubuntu:16.04

# Install all the dependencies
RUN set -ex \
    && apt-get update && apt-get install -y --no-install-recommends \
        psmisc \
        netcat-openbsd \
        net-tools \
        libc-ares-dev \
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
    && make -C /build check case=basic,py_basic verbose=true \
    # Cleanup
    && rm -rf /build \
    && apt-get purge -y --auto-remove $deps

# Setup environment variables
ENV SKULL_VERSION 1.1
ENV SKULL_GITSHA1 d2e574a969480c88197a82cd8fe824ea6e2c6bed

VOLUME /workspace
WORKDIR /workspace

# Entrypoint
CMD ["/bin/bash"]

