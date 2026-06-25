#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up all of my standard GNOME/GUI programs.
#
# To be run as root.

DNF=${DNF-dnf}

# GNOME essentials
$DNF -y install gnome-tweak-tool

# Graphical tools
$DNF -y install gimp inkscape
