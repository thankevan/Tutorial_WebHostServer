# Step 4. Host multiple static websites

Update the [`ubuntu with nginx via docker`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step3_ubuntu_with_nginx_via_dockerfile/) to host multiple websites. You can run it from [`run_this.sh`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step4_multiple_static_sites/run_this.sh).

 Changes cover:
 - have a directory per site,
 - handle custom error pages,
 - handle good subdomains that are different or the same sites,
 - allow no subdomain and www subdomain to access the same site,
 - and redirect or error for bad subdomains.

## Instructions

### Sites
To properly see the different sites locally, you'll need to update your hosts file. I added these lines:
```
127.0.0.1 site1.com
127.0.0.1 www.site1.com
127.0.0.1 site2.com
127.0.0.1 www.site2.com
127.0.0.1 sub.site2.com
127.0.0.1 bad.site2.com
127.0.0.1 site3.com
127.0.0.1 sub.site3.com
```
- Results for each:
    - localhost
        - The default Nginx site
    - site1.com
        - The site in step 2 & 3
    - www.site1.com
        - Undefined and goes to the default Nginx site
    - site2.com
        - A second site with its own 404 error page.
    - www.site2.com
        - Same as site2.
    - sub.site2.com
        - Same as site2 (used to show exclusion of bad subdomains).
    - bad.site2.com
        - Redirect to site2.com 404 error page
    - site3.com
        - A third site.
    - sub.site3.com
        - Its own separate site from site3.com (could be used for a blog, documentation, api, etc.)

### Modifying server files
I wanted to modify the nginx.conf file. This required adding lines at specific points. You can do this using `sed`. You might need to alter how `sed` is used based on your version of `sed`.

Add a line before the matching line:
```
sed -i '/regex pattern to find a line/i Insert this line before' inputfile
```

Add a line after the matching line:
```
sed -i '/regex pattern to find a line/a Insert this line after' inputfile
```


## Notes

- To attempt to catch site2 subdomains that should result in an error, I started by trying to define an Nginx regex in the proper `.conf` file: `server_name ~^(?!www\.)(?!sub\.).+\.site2.com$;`. This was unnecessary as `server_name *.site.com` will only match sites that are not previously defined.

- I had to do some debugging of the Dockerfile and the results of the commands inside of it. I used these flags within the `docker build` command in `run_this.sh`
    - To keep the output of the commands of build steps on the screen, you can add the `--progress=plain` flag. Otherwise, it defaults to `auto` which removes the output when moving to the next line. I used it with `RUN cat /etc/nginx/nginx.conf` in my Dockerfile to verify my line insertions were working correctly.
    - To make it build from scratch each time you can add the `--no-cache` flag. It still adds the resulting layers to Docker but won't reuse them in later steps. You might want to clean things up when you're done so they don't take up space. If you want to always pull a fresh image you can also add the `--pull` flag.

- Review the `.conf` files for more info.