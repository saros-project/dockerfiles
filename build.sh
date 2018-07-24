#!/bin/bash -e

project_name="saros"

gradle_tag="$project_name/gradle_alpine:openjdk-8"

version="0.2"
ci_build_tag="$project_name/ci_build:$version"
stf_test_master_tag="$project_name/stf_test_master:$version"
stf_test_slave_tag="$project_name/stf_test_slave:$version"
stf_xmpp_server_tag="$project_name/stf_xmpp_server:$version"

echo "> Building images for build and unit test process"
echo ">> Build base gradle image"
docker build --tag "$gradle_tag" -f "Dockerfile.gradle_alpine" .
echo ">> Build ci build image"
docker build --tag "$ci_build_tag" -f "Dockerfile.ci_build" .

echo "> Building images for stf testing process"
echo ">> Build xmpp server image"
docker build --tag "$stf_xmpp_server_tag" -f "Dockerfile.stf_xmpp_server" .
echo ">> Build stf slave image"
docker build --tag "$stf_test_slave_tag" -f "Dockerfile.stf_test_slave" .
