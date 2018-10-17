#!/bin/zsh

if (! (( $+commands[rustup] )) ); then
    # Intall rust through rustup tool
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

    # After installing rust we add ripgrep
    cargo install ripgrep

    return 1
fi
