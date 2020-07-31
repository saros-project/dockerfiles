#!/bin/bash -e
# Script for local docker build the productive image is created by docker cloud

project_name="saros"
version="test"

stf_test_coordinator_tag="$project_name/stf_test_coordinator:$version"
stf_test_worker_tag="$project_name/stf_test_worker:$version"
stf_xmpp_server_tag="$project_name/stf_xmpp_server:$version"

echo "> Building images for build and unit test process"
echo ">> Build ci build image"
docker build --tag "$stf_test_coordinator_tag" -f "Dockerfile.stf_test_coordinator" .

echo "> Building images for stf testing process"
echo ">> Build xmpp server image"
docker build --tag "$stf_xmpp_server_tag" -f "Dockerfile.stf_xmpp_server" .
echo ">> Build stf worker image"
docker build --tag "$stf_test_worker_tag" -f "Dockerfile.stf_test_worker" .
