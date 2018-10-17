#!/bin/sh

if [ ! -f $HOME/.config/nvim/init.vim ]; then
    # Install python3-venv otherwise Black vim plugin won't install
    sudo apt install python3-venv

    # Install python2-dev and cmake to build ycmd
    # Also to build rust completion with racer we should ensure that
    # rust and rust src are installed
    sudo apt install python2-dev cmake

    # Install vim-plug for neovim
    curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # link the nvim directory to the .config nvim directory
    ln -s "$DOTFILES"/nvim/config/init.vim $HOME/.config/nvim/init.vim

    # Install everything
    vim +PlugInstall
fi
