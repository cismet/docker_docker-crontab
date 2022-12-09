# docker_docker-crontab

Docker image with docker base image, allowing the uncomplicated execution of cronjobs

---

## crontab selection

Crontab via environment variable:
```shell
docker run --rm -e CRONTAB="* * * * * echo test" cismet/docker-crontab
```

Crontab via single file:
```shell
docker run --rm -v $(pwd)/crontab:/crontab:ro cismet/docker-crontab
```

Crontabs via directory:
```shell
docker run --rm -v $(pwd)/crontabs:/crontabs:ro cismet/docker-crontab
```

All 3 variants can also be combined:
```shell
docker run --rm \
    -e CRONTAB="* * * * * echo test" \
    -v $(pwd)/crontab:/crontab:ro \
    -v $(pwd)/crontabs:/crontabs:ro \
  cismet/docker-crontab
```

---

Using Docker inside the container:
You have to set the volume `-v /var/run/docker.sock:/var/run/docker.sock:ro` if you want to execute docker commands on the host:
```
docker run --rm --name=docker-crontab -e CRONTAB="* * * * * docker ps -l | tail -n1" -v /var/run/docker.sock:/var/run/docker.sock:ro cismet/docker-crontab
```