#!/bin/sh

set -e

DIR=/docker-entrypoint.d

if [ -d "$DIR" ]; then
  /bin/run-parts --exit-on-error "$DIR" 1>&2
fi

if [ "$1" = 'gunicorn' ]; then
 shift # "gunicorn"
  # if the user wants "haproxy", let's add a couple useful flags
  #   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
  #   -db -- disables background mode
  set -- gunicorn --access-logfile - --bind 0.0.0.0:8080 "$@" ara.server.wsgi
fi

exec "$@"
