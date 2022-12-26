FROM alpine

ARG TARGETOS
ARG TARGETARCH

RUN apk add curl --no-cache

ADD frps.ini /etc/frps.ini

RUN export VERSION=$(curl -fsSI https://github.com/fatedier/frp/releases/latest | sed -n '/tag/s/.*\/v\(.*\)/\1/p' | tr -d \\r | tr -d \\n) \
  && export FRP_FILE=frp.tar.gz \
  && echo Download https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz \
  && curl -fsSLo $FRP_FILE https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz \
  && tar xf $FRP_FILE -C /tmp \
  && mv /tmp/frp_${VERSION}_${TARGETOS}_${TARGETARCH} /frp

WORKDIR /frp

CMD ["/frp/frps", "-c", "/etc/frps.ini"]
