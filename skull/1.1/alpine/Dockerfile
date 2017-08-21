# Based on alpine
FROM alpine:3.6

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
        linux-headers \
        gcc \
        g++ \
        musl-dev \
        py2-pip \
        protobuf-c-dev \
        expect \
        valgrind \
    && apk add --no-cache \
        bash \
        yaml-dev \
        python2-dev \
        protobuf-dev \
    && pip install --upgrade setuptools pip \
    && pip install \
        PyYAML \
        protobuf \
        pympler \
        WebOb \
    # Build and Install Skull
    #  Clone branch 1.1
    && git clone --single-branch --branch 1.1 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    #  Build and Install
    && make -C /build FLIB_CFLAGS=-DFLIB_SKIP_LEGACY disable_jemalloc=true \
    #  Hack mock_ep here
    && sed -i 's/127.0.0.1 $port/127.0.0.1 -p $port/g' /build/tests/common/mock_ep \
    && make -C /build install \
    #  Verification
    && make -C /build check case=basic,py_basic verbose=true \
    && ldd `which skull-engine` \
    # Cleanup
    && rm -rf /build \
    && apk del .build-deps

# Setup environment variables
ENV SKULL_VERSION 1.1
ENV SKULL_GITSHA1 215a15906f6ca41bf5410441ba33e4d0c7aaba78

VOLUME /workspace
WORKDIR /workspace

# Entrypoint
CMD ["skull", "start", "--std-forwarding"]

