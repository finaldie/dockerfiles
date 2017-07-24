# Based on alpine
FROM alpine:3.6

# Install all the dependencies
RUN set -ex \
    && apk add --no-cache \
        coreutils \
        vim \
        make \
        linux-headers \
        gcc \
        g++ \
        gdb \
        valgrind \
        expect \
        yaml-dev \
        python2-dev \
        py2-pip \
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
        autoconf \
        musl-dev \
        protobuf-c-dev \
    # Clone tag 1.0
    && git clone --single-branch --branch 1.0 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    # Build and Install
    && make -C /build dep \
    && make -C /build install-dep \
    && make -C /build \
    && make -C /build install \
    # Verification
    && make -C /build check case=basic,py_basic debug=true \
    # Cleanup
    && rm -rf /build \
    && apk del .build-deps

# Setup environment variables
ENV SKULL_VERSION 1.0.0
ENV SKULL_GITSHA1 8dbbbb32d523f5bd86ae582bc8f98aca245f4bf1

VOLUME /workspace
WORKDIR /workspace

# Entrypoint
CMD ["/bin/bash"]

