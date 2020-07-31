#!/bin/bash -xe

. setup_utils.sh

# xfce installs the package tzdata which requires a configured timezone
echo "Europe/Berlin" > /etc/timezone
# Force tzdata to use the timezone
export DEBIAN_FRONTEND=noninteractive

apt-get -qq update

apt-get install -y \
  curl \
  tar \
  openjdk-8-jdk \
  unzip \
  dbus-x11 \
  net-tools \
  tightvncserver

apt-get install -y --no-install-recommends xfce4

install_eclipse $ECLIPSE_HOME
configure_vnc $VNC_PWD

apt-get clean
