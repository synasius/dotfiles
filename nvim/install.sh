#!/bin/sh

if [ ! -f $HOME/.config/nvim/init.vim ]; then
    # install neovim from
    sudo apt install -y neovim

    # Install python3-venv otherwise Black vim plugin won't install
    sudo apt install -y python3-venv

    # Install vim-plug for neovim
    curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    mkdir -p $HOME/.config/nvim

    # link the nvim directory to the .config nvim directory
    ln -s "$DOTFILES"/nvim/config/init.vim $HOME/.config/nvim/init.vim
    ln -s "$DOTFILES"/nvim/config/ftdetect $HOME/.config/nvim/ftdetect
    ln -s "$DOTFILES"/nvim/config/after $HOME/.config/nvim/after

    # Install everything
    echo "Run 'vim +PlugInstall' after the setup finished"
    # vim +PlugInstall

    echo "You also might want to install unstable release of Neovim from ppa"
    echo ">> sudo add-apt-repository ppa:neovim-ppa/unstable"

    return 1
fi
