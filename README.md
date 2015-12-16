# docker-pdnsd
Docker image for pdnsd, a non authoritative caching DNS server.

## Running pdnsd

The container can be created using
[docker-compose](https://docs.docker.com/compose/), the most common commands of
which being available in the makefile. To create and start a new container, run
this:

```shell
make up
```

You can override some defaults using variables. For instance, if you'd rather
have pdnsd listen on all interfaces (by default it only binds to the docker0
network interface), try this:

```shell
make up HOSTIP=0.0.0.0
```

Keep in mind, not all overrides have been tested.

## Configuration

The pdnsd configuration can be tweaked in three different ways, all found in
the volume that docker-compose will bind-mount on the host.

1. Add hosts files in `hosts.d` with custom records. Same format as
   `/etc/hosts`.
2. Add config snippets in `conf.d`. Things like `rr` sections go there.
3. Write your own `pdnsd.conf` and stick it at the root of the volume.

That's it, happy pdnsd'ing.
