# Based on alpine
FROM alpine:3.6

# Notes: Some packages are very big, like:
#  - vim: 25 MB
#  - gcc: 60+ MB
#  - g++: 60+ MB
#  - valgrind: 90+ MB

# Install all the dependencies
RUN set -ex \
    && apk add --no-cache \
        bash \
        coreutils \
        vim \
        make \
        linux-headers \
        gcc \
        g++ \
        gdb \
        musl-dev \
        valgrind \
        expect \
        yaml-dev \
        python2-dev \
        py2-pip \
        protobuf-c-dev \
        protobuf-dev \
    && pip install --upgrade setuptools pip \
    && pip install \
        PyYAML \
        protobuf \
        pympler \
        WebOb

# Build and Install Skull
RUN set -ex \
    # Install temp building tool-chains
    && apk add --no-cache --virtual .build-deps \
        git \
    # Clone tag 1.0
    && git clone --single-branch --branch 1.1 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    # Build and Install
    && make -C /build FLIB_CFLAGS=-DFLIB_SKIP_LEGACY disable_jemalloc=true \
    && sed -i 's/127.0.0.1 $port/127.0.0.1 -p $port/g' /build/tests/common/mock_ep \
    && make -C /build install \
    # Verification
    && make -C /build check skip=dns_svc verbose=true \
    # Cleanup
    && rm -rf /build \
    && apk del .build-deps

# Setup environment variables
ENV SKULL_VERSION 1.1.1
ENV SKULL_GITSHA1 9414527e75b4cdf2dce83f8905058d04ddd529b1

VOLUME /workspace
WORKDIR /workspace

# Entrypoint
CMD ["/bin/bash"]

