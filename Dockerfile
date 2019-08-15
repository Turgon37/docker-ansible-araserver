#
# First stage : download dependancies
#
FROM python:3.7.1 as deps

ARG ARA_VERSION

COPY requirements.txt /

RUN mkdir /install \
    && pip install --install-option="--prefix=/install" -r /requirements.txt \
    && pip install --install-option="--prefix=/install" 'ara[server]=='$ARA_VERSION

#
# Second stage : install ara
#
FROM python:3.7.1-alpine as base

LABEL maintainer='Pierre GINDRAUD <pgindraud@gmail.com>'

ENV ARA_BASE_DIR /ara
ENV ARA_SETTINGS $ARA_BASE_DIR/settings.yaml

COPY --from=deps /install /usr/local

RUN apk add --no-cache \
      curl \
      mariadb-dev \
      postgresql-dev \
    && apk add --no-cache --virtual .build-deps \
      gcc \
      musl-dev \
      python3-dev \
    && pip install --no-cache-dir \
      mysqlclient \
      psycopg2 \
    && apk del .build-deps \
    && mkdir /ara

VOLUME ["/ara"]

EXPOSE 8080/tcp

HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD curl --silent --fail http://localhost:8080 || exit 1

COPY /entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["gunicorn", "--workers", "4"]
