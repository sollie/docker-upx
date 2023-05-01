# UPX

[![Docker build](https://github.com/sollie/docker-upx/actions/workflows/build.yml/badge.svg)](https://github.com/sollie/docker-upx/actions/workflows/build.yml)

## Overview
A small image for usage in multi-stage Docker builds to compress binary files like Go or Rust.
Based on the official busybox image and build via multi-stage build himself to make the image as small as possible **~1.7MB**
For more information on the great tool UPX check out their [GitHub project](https://github.com/upx/upx)!

## Usage
To compress any file run following command

```bash
$ docker run --rm -w $PWD -v $PWD:$PWD ghcr.io/sollie/docker-upx:latest --best --lzma -o [compressed file name] [file name]
```
