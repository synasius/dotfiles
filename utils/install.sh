#!/usr/bin/env zsh

if (! (( $+commands[curl] )) ); then
    sudo apt install -y curl
fi

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

if (! (( $+commands[pip3] )) ); then
    sudo apt install -y python3-pip
fi

if (! (( $+commands[psql] )) ); then
    sudo apt install -y postgresql-client
fi

if (! (( $+commands[pg_config] )) ); then
    sudo apt install -y libpq-devel
fi

if (! (( $+commands[gnome-tweaks] )) ); then
    sudo apt install -y gnome-tweaks
fi

if (! (( $+commands[xclip] )) ); then
    sudo apt install -y xclip
fi

if (! (( $+commands[xclip] )) ); then
    sudo apt install -y cmake
fi

return -1
