# frp

This is an unofficial build for frp.

## Build

```bash
$ docker build -t frp .
```

## Usage

Create a `docker-compose.yml` for server:

```yaml
version: "3.7"

services:
  frp:
    image: gera2ld/frp:latest
    restart: unless-stopped
    ports:
      - "7000:7000"
      - "7000:7000/udp"
      - "7001:7001"
    volumes:
      - ./data/frps.ini:/etc/frps.ini
```

Create a `docker-compose.yml` for client:

```yaml
version: "3.7"

services:
  frp:
    image: gera2ld/frp:latest
    restart: unless-stopped
    volumes:
      - ./data/frpc.ini:/etc/frpc.ini
    command: /frp/frpc -c /etc/frpc.ini
```
