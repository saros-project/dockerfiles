#!/bin/bash -xe

. setup_utils.sh

mkdir -p $TOOLS_DIR

prepare_env

install_eclipse_plugins $ECLIPSE_HOME
install_intellij $INTELLIJ_HOME
apk add --no-cache npm

clean_env
