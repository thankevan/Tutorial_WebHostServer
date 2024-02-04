# Step 2. Nginx with attached content

Update the [`default Nginx`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step1_default_nginx/) with my own content ([`nginx_html`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step2_nginx_with_attached_content/nginx_html)) using [`run_this.sh`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step2_nginx_with_attached_content/run_this.sh).

 Changes cover:
 - remove redundant image pull and
 - use the volume flag to attach a local folder to the container to serve up my own content.