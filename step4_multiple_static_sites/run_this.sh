#!/bin/bash

# step3_ubuntu_with_nginx_via_dockerfile

# Build the image using the docker file in the current folder
# `-t` takes `name[:tag]` for the image. Tag defaults to ":latest" if not given.
docker build -t ubuntu_with_nginx_via_dockerfile_image .

echo "---"
echo "After nginx starts you can see the custom content if you navigate to:"
echo "  http://localhost:8000"

# Execute a shell on the container - allowing you to operate on it
# This effectively logs in as root.
#
# Breakdown:
#   `docker exec ... ubuntu_with_nginx_via_dockerfile_container bash`: Execute
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
echo "  docker exec -it ubuntu_with_nginx_via_dockerfile_container bash"

echo "---"
echo "To stop the running container: CONTROL-C"

# Run container based on ubuntu_with_nginx_via_dockerfile_image:latest image
#
# Breakdown:
#   `docker run ... ubuntu_with_nginx_via_dockerfile_image`: Create and start a
#         container based on the ubuntu_with_nginx_via_dockerfile_image:latest
#         image.
#     `-p 8000:80`: Tunnel my port 8000 to the container's port 80. Containers
#           run in their own docker network which is not directly accessible.
#     `--name nginx_with_attached_content_container`: name the container to make
#           it easy to restart it or run commands in it.
#     `-v ./nginx_html:/var/www/html`: use the volume flag to create or
#           overwrite the container folder on the right with the local folder on
#           the left.
#
# Notes:
#   - nginx at the end of the line automatically expands to nginx:latest (even
#         if you have other nginx tags pulled).
#
#   - The image will be pulled from docker hub automatically.
#
echo "---"
docker run -p 8000:80 --name ubuntu_with_nginx_via_dockerfile_container \
    -v ./nginx_html:/var/www/html ubuntu_with_nginx_via_dockerfile_image

echo "---"
echo "CLEAN UP"

echo "---"
echo "To remove the container run:"
echo "  docker rm ubuntu_with_nginx_via_dockerfile_container"

echo "---"
echo "To remove the image run:"
echo "  docker rmi ubuntu_with_nginx_via_dockerfile_image:latest"

echo "---"
echo "To remove any cached objects (including containers and images) run:"
echo "  docker system prune -f -a"

