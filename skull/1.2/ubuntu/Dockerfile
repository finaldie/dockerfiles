# Based on ubuntu 18.04 image
FROM ubuntu:18.04

# Install all the dependencies
RUN set -ex; \
    deps=' \
        git \
        autoconf \
        automake \
        libtool \
        make \
        gcc \
        g++ \
        libc6-dev \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        dpkg-dev \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
        # The following packages are still needed after clean up
        libyaml-dev \
    #&& pip3 install --upgrade --user setuptools pip \
    && pip3 install \
        PyYAML \
        pympler \
        WebOb \
    # Build and Install Skull
    #  Clone branch 1.2
    && git clone --single-branch --branch 1.2 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    #  Build and Install
    && make -C /build dep -j8 \
    && make -C /build install-dep \
    && make -C /build -j8 \
    && make -C /build install \
    #  Verfication
    && ldd -r `which skull-engine` \
    && pip3 list \
    && ls -l /usr/local/lib | grep proto \
    && ldd -r /usr/local/lib/libskull-api-py.so \
    && ldd -r /usr/local/lib/libskull-api-cpp.so \
    && ldd -r /usr/local/lib/libskull-unittest-cpp.so \
    && ldd -r /usr/local/lib/libskull-unittest-c.so \
    # Cleanup
    && rm -rf /build \
    && apt-get purge -y --auto-remove $deps \
    # Install python3 shared library back
    && apt-get install -y --no-install-recommends libpython3-dev \
    && rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV SKULL_VERSION 1.2
ENV SKULL_GITSHA1 a3edadc898526ef1b720dfef8c65e549c2abcae0

VOLUME /workspace
WORKDIR /workspace

EXPOSE 7758 7759

# Entrypoint
CMD ["skull", "start", "--std-forwarding"]

