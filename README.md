# wg-proxy

Singolo container Docker con WireGuard + proxy SOCKS5 + proxy HTTP (Squid).

Tutto il traffico passa attraverso il tunnel WireGuard.

## Come usare

### Con docker-compose

Modifica le variabili in `docker-compose.yml`, poi:

```bash
docker compose up -d
```

### Con docker run

```bash
docker run -d \
  --name wg-proxy \
  --cap-add NET_ADMIN \
  --cap-add SYS_MODULE \
  --sysctl net.ipv4.conf.all.src_valid_mark=1 \
  -p 1080:1080 \
  -p 8080:8080 \
  -e SOCKS5_PORT=1080 \
  -e HTTP_PORT=8080 \
  -e REQUIRE_AUTH=true \
  -e PROXY_USER=test \
  -e PROXY_PASSWORD=test \
  -e WG_INTERFACE_PRIVATE_KEY=metti_qui_la_tua_PrivateKey \
  -e WG_INTERFACE_ADDRESS=metti_qui_la_tua_Address \
  -e WG_INTERFACE_DNS=metti_qui_il_tuo_DNS \
  -e WG_PEER_PUBLIC_KEY=metti_qui_la_tua_PublicKey \
  -e WG_PEER_ALLOWED_IPS="0.0.0.0/0, ::/0" \
  -e WG_PEER_ENDPOINT=metti_qui_il_tuo_Endpoint \
  -e WG_PEER_PERSISTENT_KEEPALIVE=25 \
  ghcr.io/realbestia1/wg-proxy:latest
```



## Porte

| Porta | Proxy      | URL con auth                            | URL senza auth                    |
|-------|------------|------------------------------------------|-----------------------------------|
| 1080  | SOCKS5     | `socks5://test:test@ip-del-vps:1080`    | `socks5://ip-del-vps:1080`       |
| 8080  | HTTP (Squid)| `http://test:test@ip-del-vps:8080`     | `http://ip-del-vps:8080`         |

## Variabili d'ambiente

| Variabile              | Default     | Descrizione                          |
|------------------------|-------------|--------------------------------------|
| `SOCKS5_PORT`          | `1080`      | Porta proxy SOCKS5                   |
| `HTTP_PORT`            | `8080`      | Porta proxy HTTP                     |
| `REQUIRE_AUTH`         | `true`      | Abilita autenticazione proxy         |
| `PROXY_USER`           | —           | Utente per autenticazione            |
| `PROXY_PASSWORD`       | —           | Password per autenticazione          |
| `WG_INTERFACE_PRIVATE_KEY` | —       | Chiave privata WireGuard             |
| `WG_INTERFACE_ADDRESS` | —           | Indirizzo interfaccia WireGuard      |
| `WG_INTERFACE_DNS`     | —           | DNS per WireGuard                    |
| `WG_PEER_PUBLIC_KEY`   | —           | Chiave pubblica del peer             |
| `WG_PEER_ALLOWED_IPS`  | `0.0.0.0/0, ::/0` | Subnet permesse dal peer      |
| `WG_PEER_ENDPOINT`     | —           | Endpoint del peer                    |
| `WG_PEER_PERSISTENT_KEEPALIVE` | `25` | Keepalive secondi               |

## Build da sorgente

```bash
docker compose build
```


