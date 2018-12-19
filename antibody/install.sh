#!/usr/bin/env zsh

if (( ! $+commands[antibody] )); then
    curl -sL git.io/antibody | sh -s

fi

antibody bundle < $DOTFILES/antibody/zsh_plugins.txt > $HOME/.zsh_plugins.sh

return 1
