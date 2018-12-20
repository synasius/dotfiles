#!/usr/bin/env zsh

set -e
set -u

export DOTFILES=$(pwd -P)

echo ''

info() {
    # shellcheck disable=SC2059
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
    # shellcheck disable=SC2059
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
    # shellcheck disable=SC2059
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
    # shellcheck disable=SC2059
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

setup_gitconfig() {
    info 'setup gitconfig'
    # if there is no user.email, we'll assume it's a new machine/setup and ask it
    if [ -z "$(git config --global --get user.email)" ]; then
        user ' - What is your github author name?'
        read -r user_name
        user ' - What is your github author email?'
        read -r user_email

        git config --global user.name "$user_name"
        git config --global user.email "$user_email"
    elif [ "$(git config --global --get dotfiles.managed)" != "true" ]; then
        # if user.email exists, let's check for dotfiles.managed config. If it is
        # not true, we'll backup the gitconfig file and set previous user.email and
        # user.name in the new one
        user_name="$(git config --global --get user.name)"
        user_email="$(git config --global --get user.email)"
        mv ~/.gitconfig ~/.gitconfig.backup
        success "moved ~/.gitconfig to ~/.gitconfig.backup"
        git config --global user.name "$user_name"
        git config --global user.email "$user_email"
    else
        # otherwise this gitconfig was already made by the dotfiles
        info "already managed by dotfiles"
    fi
    # include the gitconfig.local file
    git config --global include.path ~/.gitconfig.local
    # finally make git knows this is a managed config already, preventing later
    # overrides by this script
    git config --global dotfiles.managed true
    success 'gitconfig'
}

link_file() {
    if [ -e "$2" ]; then
        if [ "$(readlink "$2")" = "$1" ]; then
            success "skipped $1"
            return 0
        else
            mv "$2" "$2.backup"
            success "moved $2 to $2.backup"
        fi
    fi
    ln -sf "$1" "$2"
    success "linked $1 to $2"
}

create_symlinks() {
    info 'creating symlinks to dotfiles'
    for src in "$DOTFILES"/**/*.symlink; do
        dst="$HOME/.$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done
}

_run() {
    "$DOTFILES"/$1/install.sh >> "$DOTFILES"/log.txt
    return $?
}

_install() {
    info "› $1 ..."

    if (_run $1); then
        info "skipped"
    else
        success "installed"
    fi
}

install_deps() {
    info 'installing and configuring dependencies'

    _install utils
    _install antibody

    _install zsh
    _install gnome-terminal
    _install rust
    _install node
    _install nvim

    _install docker
    _install dropbox
    _install pipenv
    _install tox
    _install gcloud
}


setup_gitconfig


# Create all the symlink needed
create_symlinks


# find the installers and run them iteratively
install_deps


# set zsh as the default shell
zsh="$(which zsh)"
test "$(expr "$SHELL" : '.*/\(.*\)')" != "zsh" &&
    which chsh >/dev/null 2>&1 &&
    chsh -s "$zsh" &&
    success "set $("$zsh" --version) at $zsh as default shell"

echo ''
echo '  All installed!'

echo 'Things to do:'
echo '  1 - Download a Nerd Font here: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro'
echo '  2 - Set the font as the monospace font in gnome-tweaks'
echo '  3 - Install latest release of gopass: https://github.com/gopasspw/gopass/releases/latest'
echo '  4 - Clone your vault'
echo '  5 - Install qt'
echo '  6 - Install Firefox addons: Multi-Account Container, Facebook Container'

