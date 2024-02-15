# Step 3. Ubuntu with Nginx using a Dockerfile

Update the [`nginx with attached content`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step2_nginx_with_attached_content) to be built using a Dockerfile. We're going to start with an Ubuntu image and build it out ourselves. You can run it from [`run_this.sh`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step3_ubuntu_with_nginx_via_dockerfile/run_this.sh).

 Changes cover:
 - use a Dockerfile to build the image/container,
 - build up the server using Ubuntu as a base,
 - run nginx in the foreground,
 - reroute output from nginx,
 - and update the script to handle the new setup flow.

## Some additional information

- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Docker image layers](https://docs.docker.com/build/guide/layers/)
- [Dockerfile best practices](https://docs.docker.com/develop/develop-images/guidelines/)
- [Dockerfile command best practices](https://docs.docker.com/develop/develop-images/instructions/)
- [Security best practices](https://docs.docker.com/develop/security-best-practices/)

This was my original Dockerfile before optimization and fixing how I wanted it to work. Thankfully I was able to look at the official [nginx Dockerfile online](https://github.com/nginxinc/docker-nginx/blob/4bf0763f4977fff7e9648add59e0540088f3ca9f/mainline/debian/Dockerfile) to see what they're doing. They're doing enough that when I put this together for real, I'm probably just going to use the official version because they do a lot of additional setup configuration.
```
FROM ubuntu
RUN apt update && \
    apt -y install curl git vim nano nginx nodejs && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx
CMD nginx
EXPOSE 80
EXPOSE 443
```

- It is specifically exposing ports 80 & 443 which may be handy for http and https in the future but we're tunneling 80 to 8000 and we're not dealing with https yet they aren't necessary.

- It runs nginx in the foreground (daemon off). Containers only run so long as docker can detect that they're doing something and then they automatically shut down. If nginx ran in the background as the last command, docker would start it, not be able to detect it, and shut down. But, Nginx in the foreground ignores CONTROL-C. To stop the container, you could send a stop signal to nginx using this command from another local prompt:
```
docker exec -it ubuntu_with_nginx_via_dockerfile_container nginx -s stop
```

- When I had `CMD nginx` it did not allow CONTROL-C to stop the run. I then moved the `daemon off` into the `CMD` from the `RUN` like this: `CMD ["nginx", "-g", "daemon off;"]` which did allow CONTROL-C to cancel. Further investigation shows that if I had just changed `CMD nginx` to `CMD ["nginx"]` that also would have worked.

- Sometimes, output needed rerouting. It can be fixed by adding this to the Dockerfile:
```
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
```

- The `trap INT` command in the `run_this.sh` script doesn't seem to be necessary. I now see the output from the script after the running container has been cancelled.

- The official Dockerfile also has `STOPSIGNAL SIGQUIT` which thought would fix the CONTROL-C issues (it overrides the default cancellation signal of `SIGTERM` as the signal passed into the container). In investigation I did not find necessary. But it could be that I didn't find the scenario where it was. For completeness, if the container doesn't get cancelled after 10s, Docker will then send a `SIGKILL` aka Force Quit.

- The official Dockerfile also makes use of `ENTRYPOINT` which specifies a script to call and then uses the params of `CMD` as input to the entrypoint script. I tried it but didn't wind up needing it.

- When I build off Ubuntu, the default web directory moves from `/usr/share/nginx/html` to `/var/www/html`.

- I noticed that the running container/image might not get updated as expected. At that point I would try to prune all the cached items (`docker system prune -f -a`) and eventually restarted the desktop app to refresh.
