FROM federicoponzi/horust:v0.1.7 as horust
FROM mongo:8.0.3-noble as mongodb
FROM lscr.io/linuxserver/unifi-network-application:8.5.6-ls68 as unifi

FROM ubuntu:noble

COPY --from=horust /sbin/horust /horust
COPY ./services /services

COPY --from=mongodb /usr/bin/mongo* /usr/bin/

COPY --from=unifi /usr/lib/unifi /usr/lib/unifi
COPY unifi.system.properties /usr/lib/unifi/data/system.properties

COPY pkglist /root/pkglist

# hadolint ignore=DL3008,SC2046
RUN apt-get update --yes && \
    apt-get install --no-install-recommends --no-install-suggests --yes $(cat /root/pkglist) && \
    apt-get clean autoclean --yes && \
    apt-get autoremove --yes && \
    rm -rf /var/cache/apt/archives* /var/lib/apt/lists/*


ENTRYPOINT ["/horust", "--services-path", "/services"]
