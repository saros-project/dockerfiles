#!/bin/bash -xe

. setup_utils.sh

mkdir -p $TOOLS_DIR

prepare_env

install_gradle $GRADLE_HOME

clean_env
