# Docker Ansible ARA Server

[![Build Status](https://travis-ci.org/Turgon37/docker-glpi.svg?branch=master)](https://travis-ci.org/Turgon37/docker-glpi) [![](https://images.microbadger.com/badges/image/turgon37/glpi.svg)](https://microbadger.com/images/turgon37/glpi "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/turgon37/glpi.svg)](https://microbadger.com/images/turgon37/glpi "Get your own version badge on microbadger.com")

This image contains an instance of ARA Server API served by gunicorn

:warning: Take care of the [changelogs](CHANGELOG.md) because some breaking changes may happend between versions.

## Supported tags and respective Dockerfile links

## Docker Informations

* This image expose the following port

| Port           | Usage                |
| -------------- | -------------------- |
| 8080/tcp       | HTTP web application |

 * This image takes theses environnements variables as parameters

| Environment               | Type             | Usage                                                                           |
| --------------------------|----------------- | ------------------------------------------------------------------------------- |

   * The following volumes are exposed by this image

| Volume             | Usage                                            |
| ------------------ | ------------------------------------------------ |


## Todo

* Add django authentifcation support
* Add prometheus exporter

## Installation

```
docker pull turgon37/ansible-araserver:latest
```

## Usage
