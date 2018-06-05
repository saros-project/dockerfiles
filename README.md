# Saros Dockerfile
This repository contains all files and scripts to create the docker images which are required for the CI jobs.
In order to work with docker a current docker installation is required.

## Provided images
The following images are provided:
 * Saros test and build image (Dockerfile: `Dockerfile.build_test`)
 * Saros stf testing master (Dockerfile: `Dockerfile.stf_test_master`)
 * Saros stf testing slave (Dockerfile: `Dockerfile.stf_test_slave`)
 * Saros stf testing xmpp server (Dockerfile: `Dockerfile.stf_xmpp_server`)

The main logic of the image creations is located in the corresponding setup script in `src`.

## Saros test and build image
The test and build image contains the tools and dependencies to build the following components:
 * Saros Core
 * Saros UI
 * Saros/E
 * Saros/I
 * Saros/N(etbeans) - The setting is currently not tested
 * Saros Server
 * Saros Whiteboard
 * Saros HTML GUI

All components depent on the Core component. The Core component is currently build with ant4eclipse which requires an eclipse installation.
When the core can be build without an eclipse installation it would be useful to split this big image (~ 2.1 GB) into multiple smaller images. This
would allow to run parallel build and test jobs.

## STF testing master
This image is used during the STF test process to trigger the test execution on testing slaves.
Therefore the image contains only a few tools which are required for the execution of the tests.

## STF testing slave
This image is used during the STF test process to run the tests.
Therefore the image contains an eclipse and vncserver installation.

## Build images
### Prerequisites
* Local installation of docker

### Build process
* Open bash
* Build image via docker cli client
  * `docker build -t <image tag> -f <dockerfile> <base directory>`
    * `image tag` - Contains repository name, image name and version/tag. See [tag schema](#tag-schema) for more information.
    * `dockerfile` - A dockerfile located at the root directory of this repository. The dockerfiles use the naming scheme `Dockerfile.<image name>`
    * `base directory` - Directory which will be used as reference dir of the dockerfile. Relative copy statements use the base dir as a prefix of the specified paths. Should be the project root dir.
    * Example: `docker build -t saros/stf_test_master:0.1 -f Dockerfile.stf_test_master ./`
* After the build process succeeded it is useful to test the created image with the script/software that requires the modified image.
If the test run is also successful the image can be pushed.

### Tag schema
Depending on the chosen `dockerfile` a corresponding name is needed.
The current tag schema is:
 * `Dockerfile.build_test` -> `saros/build_test:<version>`
 * `Dockerfile.stf_test_master` -> `saros/stf_test_master:<version>`
 * `Dockerfile.stf_test_slave` -> `saros/stf_test_slave:<version>`
 * `Dockerfile.stf_xmpp_server` -> `saros/stf_xmpp_server:<version>`

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
    * Example: `docker push saros/stf_test_master:0.1` 
