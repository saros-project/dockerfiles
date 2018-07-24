# Saros Dockerfile
This repository contains all files and scripts to create the docker images which are required for the CI jobs.
In order to work with docker a docker client installation is required.

## Versioning
The version/tag number is only incremented if the adjusted images would break the current Travis CI build.

## Provided images
The following images are provided:
 * Saros test, build and stf testing master image (Dockerfile: `Dockerfile.ci_build`)
 * Gradle alpine image, which is the basis of the previous images (Dockerfile: `Dockerfile.gradle_alpine`).
 * Saros stf testing slave (Dockerfile: `Dockerfile.stf_test_slave`)
 * Saros stf testing xmpp server (Dockerfile: `Dockerfile.stf_xmpp_server`)

The main logic of the image creations is located in the corresponding setup script in `src`.

## Saros test and build image

### Usage in Build and Unit-Testing
This image is used to run the gradle build and test process for Saros/E and Saros/I.
Therefore it contains all tools to build the following components:
 * Saros Core
 * Saros UI
 * Saros/E
 * Saros/I
 * Saros Server
 * Saros Whiteboard
 * Saros HTML GUI

### Usage in STF Testing
This image is used during the STF test process to trigger the test execution on testing slaves.
Therefore the image contains only a few tools which are required for the execution of the tests.

## STF testing slave
This image is used during the STF test process to run the tests.
Therefore the image contains an eclipse and vncserver installation.

## Build images

### Prerequisites
* Local installation of docker

### Build all images
* Simply call the script `build.sh` to build and tag the images in your local registry.

### Troubleshooting
The build process should fail if a command of the corresponding setup bash script fails. There are two possible reasons why this could happen:
* A bug in a Dockerfile or script
* One of the following external dependencies is not available:
  * A docker image which is used as the basis for our images
  * A uri which is defined in `src/uri_env.sh` is not reachable

## Push image to Docker Hub
### Prerequisites
* Local installation of docker
* You have a [Docker Hub account](https://hub.docker.com/)
* Your Docker Hub account is part of the [saros organization](https://hub.docker.com/u/saros/dashboard/)
* The image name is equal to the corresponding repository
  * If this is not the case retag the image by `docker tag <old tag> <new tag>`.

### Push process
* Open bash
* Log in to Docker Hub via the docker client
  * `docker login`
  * Enter user credentials
* Push image to repository
  * `docker push <image tag>`
    * Example: `docker push saros/ci_build:0.2` 
