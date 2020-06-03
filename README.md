# Docker Ansible ARA Server

[![Build Status](https://travis-ci.org/Turgon37/docker-ansible-araserver.svg?branch=master)](https://travis-ci.org/Turgon37/docker-ansible-araserver)
[![](https://images.microbadger.com/badges/image/turgon37/ansible-araserver.svg)](https://microbadger.com/images/turgon37/ansible-araserver "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/turgon37/ansible-araserver.svg)](https://microbadger.com/images/turgon37/ansible-araserver "Get your own version badge on microbadger.com")

This image contains an instance of ARA Server API served by gunicorn

:warning: Take care of the [changelogs](CHANGELOG.md) because some breaking changes may happend between versions.

## Supported tags and respective Dockerfile links

* gunicorn embedded [Dockerfile](https://github.com/Turgon37/docker-ansible-araserver/blob/master/Dockerfile)

    * `latest`

## Docker Informations

* This image expose the following port

| Port           | Usage                |
| -------------- | -------------------- |
| 8080/tcp       | HTTP web application |

* This image takes theses environnements variables as parameters

| Environment                 | Type    | Usage                                                                                                                                                     |
| ----------------------------|---------| --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ARA_SECURE_PROXY_SSL_HEADER | String  | Tuple of HTTP "header=value" which contains forwarded proto from proxy, (see https://docs.djangoproject.com/fr/2.2/ref/settings/#secure-proxy-ssl-header) |
| DJANGO_RUN_MIGRATIONS       | Boolean | Enable the django "migrate" command on container startup                                                                                                  |
| TZ                          | String  | Set the timezone                                                                                                                                          |


In addition, all ARA internal environment variables are available, see [ARA documentation](https://ara.readthedocs.io/en/latest/api-configuration.html#configuration-variables)


* The following volumes are exposed by this image

| Volume | Usage                                                        |
| ------ | ------------------------------------------------------------ |
| /ara   | ARA working directory, contains settings and SQLite database |


## Todo

* Add django authentifcation support
* Add prometheus exporter

## Installation

```
docker pull turgon37/ansible-araserver:latest
```

## Usage
