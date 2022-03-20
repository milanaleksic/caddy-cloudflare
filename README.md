# caddy-cloudflare

Build & deploy using `./build.sh`

The script depends on Docker for Desktop (Mac), because that one supports multi-arch use-case.

Create a builder with `docker buildx create --name multiarch`

Alternative to this approach: use DOCKER_HOST to point to a remote arm / x64 node
