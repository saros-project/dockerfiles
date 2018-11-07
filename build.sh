#!/bin/bash -e
# Script for local docker build the productive image is created by docker cloud

project_name="saros"
version="test"

ci_build_tag="$project_name/ci_build:$version"
stf_test_master_tag="$project_name/stf_test_master:$version"
stf_test_slave_tag="$project_name/stf_test_slave:$version"
stf_xmpp_server_tag="$project_name/stf_xmpp_server:$version"

echo "> Building images for build and unit test process"
echo ">> Build ci build image"
docker build --tag "$ci_build_tag" -f "Dockerfile.ci_build" .

echo "> Building images for stf testing process"
echo ">> Build xmpp server image"
docker build --tag "$stf_xmpp_server_tag" -f "Dockerfile.stf_xmpp_server" .
echo ">> Build stf slave image"
docker build --tag "$stf_test_slave_tag" -f "Dockerfile.stf_test_slave" .
