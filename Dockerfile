ARG CADDY_VERSION=0.0.0

FROM caddy:builder AS builder

RUN caddy-builder \
    github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Reference:
# 1. discussion: https://github.com/caddyserver/caddy/issues/3967
# 1. implementation: https://github.com/optiz0r/caddy-consul/
# Override the entrypoint with a bash script which handles SIGHUP and triggers reload
RUN apk add --no-cache tini
COPY signal-handler.sh /
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/signal-handler.sh", "caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
