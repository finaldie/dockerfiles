# Based on debian stable image
FROM debian:stretch-slim

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
    '; \
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
        # The following packages are still needed after clean up
        libyaml-dev \
        procps \
        binutils \
    #&& pip3 install --upgrade --user setuptools pip \
    && pip3 install \
        PyYAML \
        pympler \
        WebOb \
    # Build and Install Skull
    #  Clone branch 1.4
    && git clone --single-branch --branch 1.4 --depth 1 --recursive git://github.com/finaldie/skull.git /build \
    #  Build and Install
    && make -C /build dep -j8 \
    && make -C /build install-dep \
    && make -C /build -j8 \
    && make -C /build install \
    #  Verfication
    && ldd -r `which skull-engine` \
    && pip3 list \
    # Cleanup
    && rm -rf /build \
    && apt-get purge -y --auto-remove $deps \
    # Install python3 shared library back
    && apt-get install -y --no-install-recommends libpython3-dev \
    && rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV SKULL_VERSION 1.4
ENV SKULL_GITSHA1 7dcfa1f19d5166439df11d77a793febc075cac6d

VOLUME /workspace
WORKDIR /workspace

EXPOSE 7758 7759

# Entrypoint
CMD ["skull", "start", "--std-forwarding"]

