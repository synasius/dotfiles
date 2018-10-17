#!/usr/bin/env zsh

if (! (( $+commands[pipenv] )) ); then
    sudo apt install -y python3-pip

    pip3 install --user --upgrade pipenv

    return 1
fi


