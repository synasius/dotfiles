#!/bin/zsh

if (! (( $+commands[cargo] )) ); then
    # Intall rust through rustup tool
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

    # this adds cargo binary to the current en
    source $HOME/.cargo/env 
fi

if (! (( $+commands[rg] )) ); then
    cargo install ripgrep
fi
