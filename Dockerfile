# build stage
FROM alpine:3.19 as builder

ARG UPX_VERSION
ENV LDFLAGS=-static

# download source and compile
RUN apk add --no-cache \
  build-base \
  cmake \
  tar \
  wget \
  zlib-dev \
  xz

RUN wget https://github.com/upx/upx/releases/download/v$UPX_VERSION/upx-$UPX_VERSION-src.tar.xz -O /upx.tar.xz \
  && tar -xvf /upx.tar.xz -C / \
  && mv /upx-$UPX_VERSION-src /upx

RUN make -C /upx/src release

RUN /upx/build/release/upx \
  --lzma \
  -o /usr/bin/upx \
  /upx/build/release/upx

FROM busybox:1.36.1

ARG BUILD_DATE

LABEL org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.schema-version="1.0"
LABEL org.opencontainers.image.source https://github.com/sollie/docker-upx

COPY --from=builder /usr/bin/upx /usr/bin/upx

ENTRYPOINT ["/usr/bin/upx"]
