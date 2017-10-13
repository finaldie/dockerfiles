# Based on ubuntu 16.04 image
FROM ubuntu:16.04

VOLUME /workspace
WORKDIR /workspace

# Install all the dependencies
RUN set -ex; \
    deps=' \
        git \
        vim \
        build-essential \
        cmake \
        python-dev \
        python3-dev \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    # Build and Install
    && git clone --single-branch --branch master --depth 1 --recursive git://github.com/finaldie/final_dev_env.git /build \
    && make -C /build \
    && env

COPY ./bash_profile /root/.bash_profile
COPY ./install.sh /build/install.sh

RUN set -ex; \
    /build/install.sh

# Entrypoint
CMD ["/bin/bash"]

