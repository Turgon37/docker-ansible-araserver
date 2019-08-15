#!/bin/sh
set -e

if [ "$1" = 'gunicorn' ]; then
  ara_path=`python -m ara.setup.path`

  # Add missing secure proxy header setting in django settings
  django_settings_file="${ara_path}/server/settings.py"
  if [[ -f "$django_settings_file" ]] && ! grep -q SECURE_PROXY_SSL_HEADER $django_settings_file; then
    (
      echo "if settings.exists('SECURE_PROXY_SSL_HEADER'):"
      echo "  SECURE_PROXY_SSL_HEADER = tuple(settings.get('SECURE_PROXY_SSL_HEADER').split('='))"
    ) >> "${django_settings_file}"
  fi

  # Ensure timezone is correctly handled from TZ environment variable
  if ! grep -qE 'TIME_ZONE.*getenv' "${django_settings_file}"; then
    sed -i "s/^TIME_ZONE =.*/TIME_ZONE = os.getenv('TZ', 'UTC')/" "${django_settings_file}"
  fi

  # Run db migrations
  ara-manage migrate

  shift # "gunicorn"
  # if the user wants "haproxy", let's add a couple useful flags
  #   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
  #   -db -- disables background mode
  set -- gunicorn --bind 0.0.0.0:8080 "$@" ara.server.wsgi:application
fi

exec "$@"
