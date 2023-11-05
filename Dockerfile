FROM alpine AS downloader

ARG TARGETOS
ARG TARGETARCH

RUN apk add curl --no-cache

RUN VERSION=$(curl -fsSI https://github.com/fatedier/frp/releases/latest | sed -n '/tag/s/.*\/v\(.*\)/\1/p' | tr -d \\r | tr -d \\n) \
  && FRP_FILE=/tmp/frp.tar.gz \
  && NAME=frp_${VERSION}_${TARGETOS}_${TARGETARCH} \
  && URL=https://github.com/fatedier/frp/releases/download/v${VERSION}/${NAME}.tar.gz \
  && echo Download $URL \
  && curl -fsSLo $FRP_FILE $URL \
  && tar xf $FRP_FILE -C /tmp \
  && mv /tmp/$NAME /frp \
  && rm -rf /tmp/*

FROM alpine

WORKDIR /frp

COPY --from=downloader /frp /frp

ADD frps.toml /etc/frps.toml

CMD ["/frp/frps", "-c", "/etc/frps.toml"]
