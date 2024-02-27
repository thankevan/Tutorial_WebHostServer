#!/bin/bash

# step4_multiple_static_sites_image

# Build the image using the docker file in the current folder
# `-t` takes `name[:tag]` for the image. Tag defaults to ":latest" if not given.
# `--progress=plain` will keep the output of Dockerfile RUN commands.
# `--no-cache` will not use saved RUN layers from previous builds.
docker build --no-cache -t multiple_static_sites_image .

echo "---"
echo "After nginx starts you can see the custom content if you navigate to:"
echo "  http://localhost:8000"

# Execute a shell on the container - allowing you to operate on it
# This effectively logs in as root.
#
# Breakdown:
#   `docker exec ... multiple_static_sites_container bash`: Execute
#         the bash command on the specified container.
#     `-i`: interactive flag. Let what I type go to the container.
#     `-t`: pseudo-tty flag. Do a bunch of shell-like things such as give you a
#           prompt, print more than one result on a line for commands like ls,
#           etc. If you don't add this you see only the commands you type and
#           the output of those commands.
#
# Notes:
#   - The -i and -t flags are nearly always run together as -it since one lets
#         input in and the other effectively renders/formats the output.
echo "---"
echo "To get on the running container after nginx boots:"
echo "  docker exec -it multiple_static_sites_container bash"

echo "---"
echo "To stop the running container: CONTROL-C"

# Run container based on multiple_static_sites_image:latest image
#
# Breakdown:
#   `docker run ... multiple_static_sites_image`: Create and start a
#         container based on the multiple_static_sites_image:latest
#         image.
#     `-p 8000:80`: Tunnel my port 8000 to the container's port 80. Containers
#           run in their own docker network which is not directly accessible.
#     `--name multiple_static_sites_container`: name the container to make
#           it easy to restart it or run commands in it.
#     `-v ./nginx_html:/var/www/my_html`: use the volume flag to create or
#           overwrite the container folder on the right with the local folder on
#           the left. This is the folder that holds the html for my sites.
#     `-v ./nginx_confs:/etc/nginx/my_confs`: use the volume flag to create  the
#           folder that holds the conf files for my sites so I don't overwrite
#           or clear out existing conf files.
#
echo "---"
docker run -p 8000:80 --name multiple_static_sites_container \
    -v ./nginx_html:/var/www/my_html \
    -v ./nginx_confs:/etc/nginx/my_confs \
    multiple_static_sites_image

echo "---"
echo "CLEAN UP"

echo "---"
echo "To remove the container run:"
echo "  docker rm multiple_static_sites_container"

echo "---"
echo "To remove the image run:"
echo "  docker rmi multiple_static_sites_image:latest"

echo "---"
echo "To remove any cached objects (including containers and images) run:"
echo "  docker system prune -f -a"

