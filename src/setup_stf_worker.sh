#!/bin/bash -xe

function install_temurin_jdk()
{
  # eclipse temurin jdk repo
  # see https://adoptium.net/de/installation/linux/
  mkdir -p /etc/apt/keyrings
  curl -Lo /etc/apt/keyrings/adoptium.asc https://packages.adoptium.net/artifactory/api/gpg/key/public
  echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

  apt-get -qq update
  apt-get install -y temurin-11-jdk
}

function install_eclipse()
{
  local eclipse_home=$1

  local tmp_d=/tmp/setup
  local eclipse_uri="https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/photon/R/eclipse-java-photon-R-linux-gtk-x86_64.tar.gz&r=1" \

  mkdir -p "$tmp_d"
  mkdir -p "$eclipse_home"

  curl -Lo $tmp_d/eclipse.tgz $eclipse_uri
  tar -xzf $tmp_d/eclipse.tgz --strip-components=1 -C $eclipse_home

  rm -r "$tmp_d"
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

# xfce installs the package tzdata which requires a configured timezone
echo "Europe/Berlin" > /etc/timezone
# Force tzdata to use the timezone
export DEBIAN_FRONTEND=noninteractive

apt-get -qq update

apt-get install -y \
  curl \
  tar \
  unzip \
  dbus-x11 \
  net-tools \
  tightvncserver

apt-get install -y --no-install-recommends xfce4

install_temurin_jdk
install_eclipse $ECLIPSE_HOME
configure_vnc $VNC_PWD

apt-get clean
