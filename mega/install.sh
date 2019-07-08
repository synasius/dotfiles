#!/usr/bin/env zsh

if (! (( $+commands[megasync] )) ); then
    echo "Please download the MEGASync client at https://mega.nz/sync"

    return 1
fi
