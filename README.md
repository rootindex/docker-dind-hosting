# Docker in docker hosting

This container is meant to reduce the effort it takes to run multiple services in CI/CD (or anywhere else).

## How to use

Ensure your project has a docker-compose.yml file in the workdir (default: /srv).

```bash 
docker run \
    --volume ./my-app:/srv \
    --privileged \
    --publish 8080:80 \
    coisio/dind-hosting
```

## Health checks

The internal health check includes the following:

1. Check if socket exists at `/var/run/docker.sock`
2. Check if `docker-compose.yml` exists in workdir
3. Check if `dockerd` exists in the process list
