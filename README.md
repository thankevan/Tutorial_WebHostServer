# Tutorial_WebHostServer
Walking through getting Docker and Nginx set up to serve multiple sites on a single server.

## Motivation
I have used the same web hosting service for over 20 years. Their prices keep rising, updates to software happen infrequently, and they've removed some of the features I used. I mostly have static sites and it would be nice to just have a simple and inexpensive cloud server. I'd also like to learn Nginx and get more into Docker.

I chose Nginx because it seems fairly ubiquitous.\
I chose Docker so that I can have self-contained environments/servers that I can bring up and down easily during local development.

## Steps
I'll update this section with the different steps of progression. Each will be in its own directory. Where it makes sense I'll copy the previous folder to the new folder as a first step so that you can review the diff. I'll try to provide a link to the diff as well.

___

### Step 1. Default Nginx server
*Just get something running*

Located here: [step1_default_nginx](https://github.com/thankevan/Tutorial_WebHostServer/tree/main/step1_default_nginx)

___

### Step 2. Nginx with attached content
*Add some content to the default server via an attached directory*

Located here: [`step2_nginx_with_attached_content`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step2_nginx_with_attached_content/)

[See relevant changes to the script.](https://github.com/thankevan/Tutorial_WebHostServer/pull/2/commits/7e29c1c898adcad97066be8dfcabcf521667f022)

___

### Step 3. Nginx on Ubuntu using a Dockerfile
*Use a Dockerfile to setup the image and container.  Setup Nginx on Ubuntu.*

In a production environment I might still use the [nginx](https://hub.docker.com/_/nginx) image or the official [ubuntu/nginx](https://hub.docker.com/r/ubuntu/nginx) image. But, to understand how different pieces work together, I'm going to setup Nginx on a plain [ubuntu](https://hub.docker.com/_/ubuntu) image.

Located here: [`step3_ubuntu_with_nginx_via_dockerfile`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step3_ubuntu_with_nginx_via_dockerfile/)

