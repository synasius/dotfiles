#!/bin/zsh


test -d "${ZDOTDIR:-$HOME}/.zprezto" && return 0

git clone --recursive git@github.com:synasius/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

return 1
