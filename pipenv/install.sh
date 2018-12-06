#!/usr/bin/env zsh

if (! (( $+commands[pipenv] )) ); then
    pip3 install --user --upgrade pipenv

    return 1
fi


