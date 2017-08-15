# Based on ubuntu 16.04 image
FROM ubuntu:16.04

# Install all the dependencies
RUN set -ex; \
    deps=' \
        git \
        autoconf \
        libprotobuf-c0-dev \
        protobuf-c-compiler \
        make \
        gcc \
        g++ \
        libc6-dev \
        python-dev \
        python-pip \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
        # The following packages are still needed after clean up
        libyaml-dev \
        libprotobuf-dev \
        protobuf-compiler \
    && pip install --upgrade setuptools pip \
    && pip install \
        PyYAML \
        protobuf==2.6.1 \
        pympler \
        WebOb \
    # Build and Install Skull
    #  Clone branch 1.1
    && git clone --single-branch --branch 1.1 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    #  Build and Install
    && make -C /build \
    && make -C /build install \
    #  Verfication
    && ldd -r `which skull-engine` \
    # Cleanup
    && rm -rf /build \
    && apt-get purge -y --auto-remove $deps \
    # Install python2.7 shared library back
    && apt-get install -y --no-install-recommends libpython2.7 \
    && rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV SKULL_VERSION 1.1
ENV SKULL_GITSHA1 90680082b166a3ffc160646f98d98f80d17fb4a6

VOLUME /workspace
WORKDIR /workspace

# Entrypoint
CMD ["/bin/bash"]

