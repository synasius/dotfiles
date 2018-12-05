#!/usr/bin/env zsh

if (! (( $+commands[tox] )) ); then
    pip3 install --user --upgrade tox

    return 1
fi
