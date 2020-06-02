#
# First stage : download dependancies
#
FROM python:3.8-alpine as deps

ARG ARA_VERSION

COPY requirements.txt /

RUN mkdir /install \
  && pip install --prefix /install --requirement /requirements.txt \
  && pip install --prefix /install 'ara[server]=='$ARA_VERSION

#
# Second stage : install ara
#
FROM python:3.8-alpine

LABEL maintainer='Pierre GINDRAUD <pgindraud@gmail.com>'

ENV ARA_BASE_DIR /ara
ENV DJANGO_RUN_MIGRATIONS true

COPY --from=deps /install /usr/local

RUN apk add --no-cache \
       curl \
       libpq \
       mariadb-connector-c \
       tzdata \
  && apk add --no-cache --virtual .build-deps \
       gcc \
       mariadb-dev \
       musl-dev \
       postgresql-dev \
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

COPY /docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["gunicorn", "--workers", "4" ]
