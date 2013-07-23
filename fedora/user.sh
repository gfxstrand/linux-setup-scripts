#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the basics of the user account such as my
# shell and text editor.
#
# To be run as root.

# Install zsh, git, and vim.  The essential tools for life.
yum -y install zsh vim-X11 vim-enhanced git
chsh -s /bin/zsh jason

