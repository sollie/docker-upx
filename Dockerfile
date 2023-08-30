# build stage
FROM alpine:3.17 as builder

# devel branch
ARG UPX_VER
ENV LDFLAGS=-static

# download source and compile
RUN apk add --no-cache \
  build-base \
  cmake \
  tar \
  wget \
  zlib-dev \
  xz

RUN wget https://github.com/upx/upx/releases/download/v$UPX_VER/upx-$UPX_VER-src.tar.xz -O /upx.tar.xz \
  && tar -xvf /upx.tar.xz -C / \
  && mv /upx-$UPX_VER-src /upx

RUN make -C /upx/src release

RUN /upx/build/release/upx \
  --lzma \
  -o /usr/bin/upx \
  /upx/build/release/upx

# final stage
FROM scratch

ARG BUILD_DATE

LABEL org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.schema-version="1.0"
LABEL org.opencontainers.image.source https://github.com/sollie/docker-upx

COPY --from=builder /usr/bin/upx /usr/bin/upx

ENTRYPOINT ["/usr/bin/upx"]
