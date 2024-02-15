# Step 1. Default Nginx

The [`run_this.sh`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step1_default_nginx/run_this.sh) script will get Nginx up and running in Docker (you need to have [Docker installed](https://docs.docker.com/desktop/) already).

The script is heavily documented/commented. It covers:
 - pulling new images,
 - finding images that have been downloaded,
 - running containers from images,
 - "logging into" running containers, and
 - cleaning up old containers and images.

Notes:
 - Nginx configs are located at: `/etc/nginx/`.
 - Nginx default config is located at: `/etc/nginx/conf.d/default.conf`.
 - The default web directory is `/usr/share/nginx/html`.
 - The `nginx:latest` image is based off a Debian image (the Ubuntu OS is also based on Debian).
 - The official [nginx Dockerfile](https://github.com/nginxinc/docker-nginx/blob/4bf0763f4977fff7e9648add59e0540088f3ca9f/mainline/debian/Dockerfile) is available to read through.
