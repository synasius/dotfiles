#!/bin/zsh

# install SourceCodePro font from Nerd Fonts
# TODO:
#git clone https://github.com/ryanoasis/nerd-fonts.git ~/.nerd-fonts
#~/.nerd-fonts/install.sh SourceCodePro

# at the moment I can't think of a better way to tell
# whether the color profile has been installed
if [ "$(git config --global --get dotfiles.colorscheme)" != "true" ]; then

    # install Snazzy color scheme for the gnome terminal
    wget -O gogh https://git.io/fxaL7 && chmod +x gogh && ./gogh && rm -f gogh

    git config --global dotfiles.colorscheme true

    return 1
fi
