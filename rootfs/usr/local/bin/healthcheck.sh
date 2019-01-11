#!/bin/sh

test -S /var/run/docker.sock \
    && test -f docker-compose.yml \
    && ps aux | grep [d]ockerd\

exit $?