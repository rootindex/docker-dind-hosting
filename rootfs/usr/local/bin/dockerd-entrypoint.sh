#!/bin/sh
set -e

# determine what action to take
if [[ "$#" -eq 0 ]]; then
    # explicitly remove Docker's default PID file to ensure
    # that it can start properly if it was stopped uncleanly
    # (and thus didn't clean up the PID file)
    find /run /var/run -iname 'docker*.pid' -delete
    # let's pipe through dind (use "sh" because shebang is /bin/bash)
    # setting log level to error, no need for more details
    sh /usr/local/bin/dind dockerd \
        --host=unix:///var/run/docker.sock \
        --log-level=error &
    echo "[ x ] Started docker in docker"
    # wait until the socket becomes active
    while [[ ! -S /var/run/docker.sock ]]; do
        sleep 1
    done;
    # wait for docker compose file
    while [[ ! -f docker-compose.yml ]]; do
        sleep 5;
        echo "[ !! ] Waiting for docker-compose file"
    done;
    # ready to start full application
    echo "[ x ] Executing docker compose"
    docker-compose up --no-color --quiet-pull &
    # lets wait for SIGTERM
    wait
else
    # custom execution, let her rip
    exec "$@"
fi