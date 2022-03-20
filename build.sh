#!/usr/bin/env bash

# latest on 10/02/2022
export CADDY_VERSION=2.4.6

# This depends on Docker for Desktop (Mac), because that one supports multi-arch output
# Create that builder with "docker buildx create --name multiarch"
# Alternative: use DOCKER_HOST to point to a remote arm / x64 node
docker buildx use multiarch
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg CADDY_VERSION=${CADDY_VERSION} \
  -t milanaleksic/caddy-cloudflare:${CADDY_VERSION} \
  --push \
  .

# NOTE: this image can't be remo