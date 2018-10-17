#!/usr/bin/env zsh

if (! (( $+commands[tree] )) ); then
    sudo apt install -y tree
fi

if (! (( $+commands[clang-format] )) ); then
    sudo apt install -y clang-format
fi

if (! (( $+commands[bison] )) ); then
    sudo apt install -y bison
fi

if (! (( $+commands[flex] )) ); then
    sudo apt install -y flex
fi
