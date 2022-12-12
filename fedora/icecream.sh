#! /bin/bash
# Fedora setup script for Fedora >= 35
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the basics of the user account such as my
# shell and text editor.
#
# To be run as root.

DNF=${DNF-dnf}

# Install zsh, screen, git, and vim.  The essential tools for life.
$DNF -y install icecream

# Enable firewall rules
firewall-cmd --zone="home" --add-service=icecream --permanent
firewall-cmd --reload

systemctl enable iceccd
systemctl start iceccd
