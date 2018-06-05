#!/bin/bash -xe

. setup_utils.sh

apt-get -qq update

apt-get install -y \
  openjdk-6-jdk \
  ant \
  curl \
  tar

install_cobertura $COBERTURA_HOME old

install_junit $JUNIT_HOME
install_eclipse $ECLIPSE_HOME

clean_tmp
