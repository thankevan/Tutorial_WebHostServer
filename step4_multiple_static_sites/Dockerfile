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

# After the include sites-enabled line, insert a line to include the conf files
# in the my_confs directory (attached as a volume)
RUN sed -i '/.*include.*sites-enabled.*;/a include /etc/nginx/my_confs/*.conf;' /etc/nginx/nginx.conf

# After the error.log line, insert a line toprevent escaping the log output to
# keep in human readable. The format given is the predefined log format from:
# https://nginx.org/en/docs/http/ngx_http_log_module.html#log_format
RUN sed -i "/.*error.log.*/a log_format  combined_unescaped escape=none '\$remote_addr - \$remote_user [\$time_local] \"\$request\" \$status \$body_bytes_sent \"\$http_referer\" \"\$http_user_agent\" \"\$gzip_ratio\"';" /etc/nginx/nginx.conf
RUN cat /etc/nginx/nginx.conf


# Run nginx in the foreground so docker doesn't stop the container
CMD ["nginx", "-g", "daemon off;"]

# EXPOSE is more a comment on the state of the server ports than anything real.
# From https://docs.docker.com/engine/reference/builder/#expose -
# "It functions as a type of documentation between the person who builds the
#   image and the person who runs the container"
EXPOSE 80
