#!/bin/bash

# Get the nginx:latest image (name:tag) if we don't already have it
#
# Breakdown:
#   `if ! ... ; then`: only execute if the ... part fails
#     `docker image inspect ... nginx:latest`: get info about the specified
#           image, a prebaked nginx image of the latest version
#       `--format="exists"`: instead of giving all the info, just output the
#           word "exists" (this is basically ignored though)
#       `&>/dev/null`: take all output (stdio & stderr) and throw them both away
#     output: success if it finds the image, fail if it doesn't
#   `docker pull nginx:latest`: it didn't find the image, so pull it down
#
#   Notes:
#     - Could have done `docker image -q nginx:latest` which would return the id
#       but it is much slower if you have a lot of images because it iterates
#       through each rather than going directly to the specific image.
#
#     - https://hub.docker.com is where you can find docker images
if ! docker image inspect --format="exists" nginx:latest &>/dev/null; then
  docker pull nginx:latest
fi

echo "---"
echo "After nginx boots you can see the default nginx page if you navigate to:"
echo "  http://localhost:8000"

# Execute a shell on the container - allowing you to operate on it
# This effectively logs in as root.
#
# Breakdown:
#   `docker exec ... default-nginx-container sh`: Execute the sh command on
#         the container default-nginx-container.
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
echo "  docker exec -it default-nginx-container sh"

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
#     `--name default-nginx-container`: name the container to make it easy
#           to restart it or run commands in it.
#
# Notes:
#   - nginx at the end of the line automatically expands to nginx:latest (even
#         if you have other nginx tags pulled).
#
#   - If it doesn't exist it will pull it from docker hub automatically (yes,
#         this makes lines 21-23 redundant).
#
echo "---"
docker run -p 8000:80 --name default-nginx-container nginx

echo "---"
echo "CLEAN UP"

echo "---"
echo "To remove the container run:"
echo "  docker rm default-nginx-container"

echo "---"
echo "To remove the image run:"
echo "  docker rmi nginx:latest"
