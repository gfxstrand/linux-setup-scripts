#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up my vim config
#
# To be run as the regular user

set -e

cp ../.vimrc $HOME/

mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/bundle"
curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim
cd "$HOME/.vim/bundle"
git clone https://github.com/ctrlpvim/ctrlp.vim
git clone https://github.com/editorconfig/editorconfig-vim
