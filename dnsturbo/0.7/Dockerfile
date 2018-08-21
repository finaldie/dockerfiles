# Build DNSTurbo
FROM finaldie/skull:1.3-build as builder

WORKDIR /build

RUN set -ex \
    && buildDeps=' \
        git \
        libc-ares-dev \
    ' \
    && apt-get update && apt-get install -y --no-install-recommends \
        $buildDeps \
    && git clone --single-branch --branch 0.7 --depth 1 --recursive git://github.com/finaldie/DNSTurbo.git /build \
    && skull build \
    && skull deploy \
    # Public command port
    && sed -i 's/# command_bind:.*/command_bind: 0.0.0.0/g' run/skull-config.yaml \
    && rm -rf /var/lib/apt/lists/*

# Runable Image
FROM finaldie/skull:1.3

RUN set -ex; \
    buildDeps=' \
        python3-pip \
        python3-setuptools \
        python3-wheel \
    ' \
    && apt-get update && apt-get install -y --no-install-recommends \
        $buildDeps \
        libc-ares-dev \
    && pip3 install \
        dnslib \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY --from=builder /build/run .

EXPOSE 53 7759

ENV DNSTURBO 0.7.3

# Entrypoint
CMD ["skull", "start", "--std-forwarding"]

