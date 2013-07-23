#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up all of my standard GNOME/GUI programs.
#
# To be run as root.

# GNOME essentials
yum -y install gnome-tweak-tool epiphany

# Install wine for Microsoft Office etc.
yum -y install wine

yum -y install gimp
yum -y install gnucash

