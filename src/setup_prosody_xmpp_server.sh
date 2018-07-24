#!/bin/bash -e

apt-get -qq update
apt-get install -y prosody 
apt-get clean && 

cp prosody.cfg.lua /etc/prosody/
chown root:prosody /etc/prosody/prosody.cfg.lua

mkdir -p /var/run/prosody
chown -R prosody:prosody /var/run/prosody
