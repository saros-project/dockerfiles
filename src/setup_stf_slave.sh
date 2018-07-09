#!/bin/bash -xe

. setup_utils.sh

apt-get -qq update

apt-get install -y \
  curl \
  tar \
  openjdk-6-jdk \
  unzip \
  tightvncserver

apt-get install -y --no-install-recommends xfce4

install_cobertura $COBERTURA_HOME old
install_eclipse $ECLIPSE_HOME

configure_vnc $VNC_PWD

clean_tmp
