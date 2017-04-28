FROM alpine:edge
MAINTAINER CHENHW2 <https://github.com/chenhw2>

ARG BIN_URL=https://github.com/chenhw2/dnspod-http-dns/releases/download/v20170428/dnspod-http-dns_linux-amd64-20170428.tar.gz

RUN apk add --update --no-cache wget supervisor ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /opt \
    && cd /opt \
    && wget -qO- ${BIN_URL} | tar xz \
    && mv dnspod-http-dns_* dnspod-http-dns

ADD Docker_entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5300
EXPOSE 5300/udp

ENTRYPOINT ["/entrypoint.sh"]
