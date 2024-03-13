# Step 5. Use docker compose

Update the [`multiple static sites`](https://github.com/thankevan/Tutorial_WebHostServer/blob/main/step4_multiple_static_sites/) to use a dockerfile. You can now run it with `docker compose up`. 

 Changes cover:
 - Move the commands from `run_this.sh` to `docker-compose.yml` 

## Instructions

### Sites

- We're reusing the sites from step 4.

### Docker commands

```
docker compose up
```
Build the image and bring up the container. You cand also use the `-d` flag to run in "detached" mode which will run the container in the background.


```
docker compose down
```
Remove the container.

```
docker compose stop
```
Stop the container.

```
docker compose start
```
Start the container.

```
docker exec -it <container name> bash
```
You can still use this command to log onto the container, watch the output of docker compose to see what the container name is.

```
docker rm -f $(docker ps -aq || echo "-")
```
Removes all containers. This calls `docker ps -aq` to get all the container ids and passes them to `docker rm -f` which will force them to be removed, running or not. The `echo "-"` is there just to prevent an error if there are no running containers. In that case "-" will be passed to `docker rm -f` and then it won't find that container. I guess that still results in it complaining that it can't find the container but not that you don't know how to use the command.

```
docker rmi -f $(docker images -aq || echo "-")
```
Removes all images. Same as above only it's using the image versions of the commands.

```
docker system prune -af --volumes
```
Removes cached objects, unused images, and volumes.


