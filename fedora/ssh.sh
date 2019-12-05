#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up ssh.
#
# To be run as root.

DNF=${DNF-dnf}

# Install zsh, git, and vim.  The essential tools for life.
$DNF -y install openssh-server
systemctl start sshd.service
systemctl enable sshd.service

