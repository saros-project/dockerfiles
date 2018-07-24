#!/bin/bash
# The script assumes that the env var *_URI are set

. uri_env.sh

tmp_d=/tmp/setup
mkdir -p $tmp_d

req_default_packages="unzip tar curl"

function prepare_env()
{
  apk add --no-cache $req_default_packages
}

function clean_env()
{
  rm -r "$tmp_d"
  apk del $req_default_packages
}

function install_gradle()
{
  local gradle_home=$1

  mkdir -p $gradle_home
  curl -Lo $tmp_d/gradle.zip $GRADLE_URI
  unzip $tmp_d/gradle.zip -d $gradle_home
  mv $gradle_home/gradle-*/* $gradle_home/
}

function install_eclipse_plugins()
{
  local eclipse_home=$1
  install_eclipse "$eclipse_home"

  # Only the plugin dir is required for build
  cd $eclipse_home
  ls -1 | grep -v plugins | xargs rm -r
  cd -
}

function install_eclipse()
{
  local eclipse_home=$1

  mkdir -p $eclipse_home
  curl -Lo $tmp_d/eclipse.tgz $ECLIPSE_URI
  tar -xzf $tmp_d/eclipse.tgz --strip-components=1 -C $eclipse_home
}

function install_intellij_lib()
{
  local intellij_home=$1
  install_intellij "$intellij_home"

  # Only the lib dir is required for build
  cd $intellij_home
  ls -1 | grep -v lib | xargs rm -r
  cd -
}

function install_intellij()
{
  local intellij_home=$1

  mkdir -p $intellij_home
  curl -Lo $tmp_d/intellij.tgz $INTELLIJ_URI
  tar -xzf $tmp_d/intellij.tgz --strip-components=1 -C $intellij_home

}

function configure_vnc()
{
  local vnc_pwd=$1

  mkdir -p ~/.vnc
  echo "$vnc_pwd" | vncpasswd -f >> ~/.vnc/passwd
  chmod 600 ~/.vnc/passwd

  echo '#!/bin/bash' >> ~/.vnc/xstartup
  echo 'xrdb $HOME/.Xresources' >> ~/.vnc/xstartup
  echo 'startxfce4 &' >> ~/.vnc/xstartup
  chmod +x ~/.vnc/xstartup
}
