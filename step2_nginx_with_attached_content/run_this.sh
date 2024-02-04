#!/bin/bash

# step2_nginx_with_attached_content

echo "---"
echo "After nginx boots you can see the custom content if you navigate to:"
echo "  http://localhost:8000"

# Execute a shell on the container - allowing you to operate on it
# This effectively logs in as root.
#
# Breakdown:
#   `docker exec ... nginx_with_attached_content_container sh`: Execute the sh
#         command on the container nginx_with_attached_content_container.
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
echo "  docker exec -it nginx_with_attached_content_container sh"

echo "---"
echo "To stop the running container: CONTROL-C"

# When you hit CONTROL-C to exit the container, continue running the script
trap INT

# Run container based on nginx:latest image
#
# Breakdown:
#   `docker run ... nginx`: Create and start a container based on the
#         nginx:latest image.
#     `-p 8000:80`: Tunnel my port 8000 to the container's port 80. Containers
#           run in their own docker network which is not directly accessible.
#     `--name nginx_with_attached_content_container`: name the container to make
#           it easy to restart it or run commands in it.
#     `-v ./nginx_html:/usr/share/nginx/html`: use the volume flag to create or
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
docker run -p 8000:80 --name nginx_with_attached_content_container -v ./nginx_html:/usr/share/nginx/html nginx

echo "---"
echo "CLEAN UP"

echo "---"
echo "To remove the container run:"
echo "  docker rm nginx_with_attached_content_container"

echo "---"
echo "To remove the image run:"
echo "  docker rmi nginx:latest"
