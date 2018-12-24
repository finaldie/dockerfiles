# Based on alpine
FROM alpine:3.8

# Notes: Some packages are very big, like:
#  - vim: 25 MB
#  - gcc: 60+ MB
#  - g++: 60+ MB
#  - valgrind: 90+ MB

# Install all the dependencies
RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        git \
        coreutils \
        make \
        autoconf \
        automake \
        libtool \
        linux-headers \
        gcc \
        g++ \
        musl-dev \
        expect \
        valgrind \
        file \
    && apk add --no-cache \
        bash \
        yaml-dev \
        python3-dev \
    && pip3 install \
        PyYAML \
        pympler \
        WebOb \
    # Build and Install Skull
    #  Clone branch 1.4
    && git clone --single-branch --branch 1.4 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    #  Build and Install
    && make -C /build dep -j8 disable_jemalloc=true \
    && make -C /build install-dep \
    #   - Notes: On alpine, link with jemalloc would cause segment fault, diable
    #            it for now until have a better solution
    && make -C /build -j8 disable_jemalloc=true \
    && make -C /build install \
    #  Hack mock_ep here
    && sed -i 's/127.0.0.1 $port/127.0.0.1 -p $port/g' /build/tests/common/mock_ep \
    #  Verification
    && ldd `which skull-engine` \
    && pip3 list \
    && make -C /build check case=basic,py_basic verbose=true \
    # Cleanup
    && rm -rf /build \
    && apk del .build-deps

# Setup environment variables
ENV SKULL_VERSION 1.4
ENV SKULL_GITSHA1 7e24f2c4d1d2a865286f540c7dca5f4377504883

VOLUME /workspace
WORKDIR /workspace

EXPOSE 7758 7759

# Entrypoint
CMD ["skull", "start", "--std-forwarding"]

