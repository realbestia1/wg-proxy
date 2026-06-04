FROM ginuerzh/gost:latest AS gost

FROM lscr.io/linuxserver/wireguard:latest
COPY --from=gost /bin/gost /usr/local/bin/gost

RUN apk add --no-cache openssl

COPY overlay/ /
RUN chmod +x /etc/cont-init.d/* \
    /etc/s6-overlay/s6-rc.d/*/run 2>/dev/null || true
