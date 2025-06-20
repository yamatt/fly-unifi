FROM federicoponzi/horust:v0.1.9 as horust
FROM mongo:8.0.10-noble as mongodb
FROM lscr.io/linuxserver/unifi-network-application:8.6.9-ls68 as unifi

FROM ubuntu:noble

COPY --from=horust /sbin/horust /horust
COPY ./services /services

COPY --from=mongodb /usr/bin/mongo* /usr/bin/

COPY --from=unifi /usr/lib/unifi /usr/lib/unifi
COPY configs/unifi.system.properties /usr/lib/unifi/data/system.properties

COPY configs/pkglist /root/pkglist

# hadolint ignore=DL3008,SC2046
RUN apt-get update --yes && \
    apt-get install --no-install-recommends --no-install-suggests --yes $(cat /root/pkglist) && \
    apt-get clean autoclean --yes && \
    apt-get autoremove --yes && \
    rm -rf /var/cache/apt/archives* /var/lib/apt/lists/*

COPY configs/haproxy.cfg /etc/haproxy/haproxy.cfg


ENTRYPOINT ["/horust", "--services-path", "/services"]
