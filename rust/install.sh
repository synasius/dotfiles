#!/bin/zsh

if (! (( $+commands[cargo] )) ); then
    # Install rust through rustup tool
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

    # this adds cargo binary to the current env
    source $HOME/.cargo/env

    # Installing some useful components
    rustup component add rustfmt clippy rls rust-analysis
fi

if (! (( $+commands[rg] )) ); then
    cargo install ripgrep
fi

