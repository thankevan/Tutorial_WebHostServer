FROM ubuntu

# You always need to update the package manager because it will be out of date.
# Then I install some things to make the image easier to interact with.
# Make sure the `/var/lib/nginx` folder has the right permissions.
RUN apt update && \
    apt -y install curl git vim nano nginx && \
    chown -R www-data:www-data /var/lib/nginx

# Create links to forward the nginx access.log to stdout and the nginx error.log
# to stderr so they will pick up in the docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Run nginx in the foreground so docker doesn't stop the container
CMD ["nginx", "-g", "daemon off;"]

# EXPOSE is more a comment on the state of the server ports than anything real.
# From https://docs.docker.com/engine/reference/builder/#expose -
# "It functions as a type of documentation between the person who builds the
#   image and the person who runs the container"
EXPOSE 80
