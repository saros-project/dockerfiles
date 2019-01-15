# Saros Dockerfile
This repository contains all files and scripts to create the docker images which are required for the CI jobs.
In order to work with docker a docker client installation is required.

## Create a new image tag in Docker Hub
Our images are hosted by [Docker Hub](https://hub.docker.com/u/saros).
Each new pull request triggers a new image build within Docker Hub, but the result of the build is not tagged and cannot be used.
Docker Hub maps the git/GitHub tags to docker tags. Therefore you have to create a [new git tag](https://git-scm.com/book/en/v2/Git-Basics-Tagging) in order to create a new tagged image.

If you want to publish a new image you have to:
* Merge your pull request into master
* Create a new git tag with:
  * open bash
  * change directory to local `saros-project/dockerfiles` repository
  * `git tag -a <tag name> <commit to be tagged> -m <tag message>`
  * `git push --tags origin master`

## Build images locally

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

## Explanation of provided images
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

