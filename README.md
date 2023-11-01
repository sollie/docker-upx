# UPX Docker Image

![Docker build status](https://github.com/sollie/docker-upx/actions/workflows/build.yml/badge.svg)

## Introduction
This repository contains a lightweight Docker image designed for use in multi-stage
Docker builds. The image is based on the official busybox image and is built using a
multi-stage process to minimize its size.

For more details about UPX, the powerful executable packer used in this image,
please visit the [UPX GitHub project](https://github.com/upx/upx).

## How to Use
To compress a file using this Docker image, execute the following command:

```bash
$ docker run --rm -w $PWD -v $PWD:$PWD ghcr.io/sollie/docker-upx:latest --best --lzma -o [output file name] [input file name]
```

Replace `[output file name]` with the name you want for your compressed file,
and `[input file name]` with the name of the file you want to compress.
The `--best` and `--lzma` options ensure optimal compression.
