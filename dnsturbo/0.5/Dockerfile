# Build DNSTurbo
FROM finaldie/skull:1.1-build as builder

WORKDIR /build

RUN set -ex \
    && buildDeps=' \
        git \
        libc-ares-dev \
    ' \
    && apt-get update && apt-get install -y --no-install-recommends \
        $buildDeps \
    && git clone --single-branch --branch master --depth 1 --recursive git://github.com/finaldie/DNSTurbo.git /build \
    && skull build \
    && skull deploy \
    && rm -rf /var/lib/apt/lists/*

# Runable Image
FROM finaldie/skull:1.1

RUN set -ex; \
    buildDeps=' \
        python-pip \
    ' \
    && apt-get update && apt-get install -y --no-install-recommends \
        $buildDeps \
        libc-ares-dev \
    && pip install \
        dnslib \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY --from=builder /build/run .

EXPOSE 53

ENV DNSTURBO 0.5.1

# Entrypoint
CMD ["skull", "start", "--std-forwarding"]

