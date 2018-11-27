#!/usr/bin/env zsh

if (! (( $+commands[docker] )) ); then
    # to install docker follow the steps documented at
    # https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
    sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # install repository for bionic because cosmic it's not available yet
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    sudo apt update && sudo apt install -y docker-ce

    # configure docker group to alow non privileged user to run docker
    #sudo groupadd docker
    sudo usermod -aG docker $USER

    # also disable docker deamon at boot
    sudo systemctl disable docker

    # Install docker-compose
    pip3 install --user --upgrade docker-compose

    return 1
fi
