#!/bin/bash
# The script assumes that the env var *_URI are set

. uri_env.sh

tmp_d=/tmp/setup
mkdir -p $tmp_d

function clean_tmp()
{
  apt-get clean
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
}

function install_pmd()
{
  local pmd_home=$1

  mkdir -p $pmd_home
  curl -Lo $tmp_d/pmd.zip $PMD_URI
  unzip $tmp_d/pmd.zip -d $pmd_home
  mv $pmd_home/pmd-*/* $pmd_home/ 
}

function install_findbugs()
{
  local findbugs_jar=$1
  curl -Lo $findbugs_jar $FINDBUGS_URI
}

function install_junit()
{
  local junit_home=$1

  mkdir -p $JUNIT_HOME
  cd $JUNIT_HOME
  curl -LO $JUNIT_URI
  curl -LO $HAMCREST_URI
  cd -
}

function install_eclipse()
{
  local eclipse_home=$1

  mkdir -p $eclipse_home
  curl -Lo $tmp_d/eclipse.tgz $ECLIPSE_URI
  tar -xzf $tmp_d/eclipse.tgz --strip-components=1 -C $eclipse_home

  cd $eclipse_home/plugins
  curl -LO $GEF_URI
  curl -LO $GEF_DRAW_URI
  cd -
}

function install_intellij()
{
  local intellij_home=$1

  mkdir -p $intellij_home
  curl -Lo $tmp_d/intellij.tgz $INTELLIJ_URI
  tar -xzf $tmp_d/intellij.tgz --strip-components=1 -C $intellij_home
}

function install_netbeans()
{
  local netbeans_home=$1

  mkdir -p $netbeans_home
  curl -Lo $tmp_d/netbeans.zip $NETBEANS_URI
  unzip $tmp_d/netbeans.zip -d $netbeans_home
  mv $netbeans_home/netbeans/* $netbeans_home/
}

function install_node_npm()
{
  local node_home=$1

  mkdir -p $node_home
  curl -Lo $tmp_d/node.tgz $NODE_URI
  tar -xzf $tmp_d/node.tgz --strip-components=1 -C $node_home
}

function install_cobertura()
{
  local cobertura_home=$1
  local version=$2
  local uri=""

  [ "$version" = "new" ] && uri=$COBERTURA_NEW_URI || uri=$COBERTURA_URI

  mkdir -p $cobertura_home
  curl -Lo $tmp_d/cobertura.tgz $uri
  tar -xzf $tmp_d/cobertura.tgz --strip-components=1 -C $cobertura_home
  chmod +x $cobertura_home/cobertura-instrument.sh

  if [ "$version" = "new" ]; then
    cobertura_new_jar=$(find $cobertura_home -maxdepth 1 -type f -name "cobertura-*[0-9].jar")
    ln -s $cobertura_new_jar "$cobertura_home/cobertura.jar"
  fi
}

function install_ant4eclipse()
{
  local ant4_eclipse_home=$1
  local version=$2
  local uri=""

  [ "$version" = "new" ] && uri=$ANT4ECLIPSE_NEW_URI || uri=$ANT4ECLIPSE_URI

  mkdir -p $ant4_eclipse_home
  curl -Lo $tmp_d/ant4eclipse.tgz $uri
  tar -xzf $tmp_d/ant4eclipse.tgz -C $ant4_eclipse_home
  unzip $ant4_eclipse_home/org.ant4eclipse-source*.zip -d $ant4_eclipse_home/
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
