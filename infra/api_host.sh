#!/bin/bash

function ubuntu_pre_reqs {
    # Install Docker
    export DEBIAN_FRONTEND=noninteractive
    sudo apt update -qy
    sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg -qy
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
    sudo apt update -qy
    DOCKER_VERSION=`sudo apt-cache madison docker-ce | grep '19.03.13' | awk '{print $3}'`
    DOCKER_CLI_VERSION=`sudo apt-cache madison docker-ce-cli | grep '19.03.13' | awk '{print $3}'`
    sudo apt install docker-ce=$DOCKER_VERSION docker-ce-cli-$DOCKER_CLI_VERSION -qy
}

function rhel_pre_reqs {
    DOCKER_VERSION=`sudo dnf --showduplicates list docker-ce | grep '19.03.13' | awk '{print $2}'`
    DOCKER_CLI_VERSION=`sudo dnf --showduplicates list docker-ce-cli | grep '19.03.13' | awk '{print $2}'`
    sudo dnf install docker-ce-$DOCKER_VERSION docker-ce-cli-$DOCKER_CLI_VERSION -y
    sudo systemctl enable --now docker
}

function dist_check() {
  if [ -e /etc/os-release  ]; then
    source /etc/os-release
    DISTRO=$ID
  fi
}

dist_check

if [ "$DISTRO" == "ubuntu" ]; then
    ubuntu_pre_reqs
elif [ "$DISTRO" == "centos" ]; then
    rhel_pre_reqs
else; then
    echo "I'm not sure which OS this is! Doing nothing..."
fi

