#!/bin/bash

# Version override settings
#docker_version="5:18.09.9~3-0~debian-buster"
#compose_version="1.25.0"



# Install software used for downloading Docker
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y curl apt-transport-https ca-certificates \
                   gnupg-agent software-properties-common

# Set default versions if override settings don't exist
if [ -z ${docker_version+x} ]; then
  packages="docker-ce docker-ce-cli containerd.io"
else
  packages="docker-ce=${docker_version} docker-ce-cli=${docker_version} containerd.io"
fi

url="https://github.com/docker/compose/releases"
if [ -z ${compose_version+x} ]; then
  latest=$(curl -s ${url}/latest | grep -o releases/tag/*.*\")
  compose_version=$(echo $latest | awk '{print substr($1, 14, length($1) - 14)}')
fi

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 9DC858229FC7DD38854AE2D88D81803C0EBFCD88

# Install Docker respository
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"

# Install Docker
apt-get update
apt-get install -y $packages
usermod -aG docker vagrant

# Install Docker Compose
file="docker-compose-$(uname -s)-$(uname -m)"
curl -sL "$url/download/$compose_version/$file" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
