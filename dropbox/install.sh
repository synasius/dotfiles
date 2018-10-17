#!/usr/bin/env zsh

if (! (( $+commands[dropbox] )) ); then
    # Download Dropbox client
    sudo apt install -y nautilus-dropbox

    return 1
fi
