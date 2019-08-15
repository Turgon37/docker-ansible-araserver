#!/bin/sh
set -e

if [ "$1" = 'gunicorn' ]; then
  ara-manage migrate

  shift # "gunicorn"
  # if the user wants "haproxy", let's add a couple useful flags
  #   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
  #   -db -- disables background mode
  set -- gunicorn --bind 0.0.0.0:8080 "$@" ara.server.wsgi:application
fi

exec "$@"
