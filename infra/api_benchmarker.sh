#!/bin/bash

function ubuntu_pre_reqs() {
    export DEBIAN_FRONTEND=noninteractive
    sudo apt update -y
    sudo apt-get install apache2-utils build-essential git  -qy
}

function rhel_pre_reqs() {
    sudo dnf install apache2-utils git "Development Tools" -y
}

function dist_check() {
  if [ -e /etc/os-release  ]; then
    source /etc/os-release
    DISTRO=$ID
  fi
}

function wrk_install() {
    cd ~
    git clone https://github.com/wg/wrk.git
    cd wrk
    make -j$(nproc)
    chmod a+x wrk
    sudo cp wrk /usr/local/bin/
}

dist_check

if [ "$DISTRO" == "ubuntu" ]; then
    ubuntu_pre_reqs
elif [ "$DISTRO" == "centos" ]; then
    rhel_pre_reqs
else; then
    echo "I'm not sure which OS this is! Doing nothing..."
    exit 1
fi

wrk_install

