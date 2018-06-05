#!/bin/bash -xe

. setup_utils.sh

useradd -ms /bin/bash saros

mkdir -p $TOOLS_DIR

apt-get -qq update
# openjdk-6 is used to build Saros/E, Core, Whiteboard and ui
apt-get install --no-install-recommends -y \
  curl \
  tar \
  openjdk-6-jdk \
  openjdk-7-jdk \
  unzip \
  software-properties-common
apt-get install -y ant

# The command add-apt-repository is installed via software-properties-common
add-apt-repository ppa:openjdk-r/ppa -y
apt-get -qq update
apt-get install -y openjdk-8-jdk

install_ant4eclipse $ANT4ECLIPSE_HOME old
install_ant4eclipse $ANT4ECLIPSE_NEW_HOME new

install_cobertura $COBERTURA_HOME old
install_cobertura $COBERTURA_NEW_HOME new

install_pmd $PMD_HOME
install_findbugs $FINDBUGS_JAR
install_junit $JUNIT_HOME

install_eclipse $ECLIPSE_HOME
install_intellij $INTELLIJ_HOME
install_netbeans $NETBEANS_HOME

install_node_npm $NODE_HOME

clean_tmp
