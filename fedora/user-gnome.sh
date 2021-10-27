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
$DNF -y install gnome-tweak-tool epiphany

# Install wine and mono for windows apps.
$DNF -y install wine mono-devel mono-winforms

# Graphical tools
$DNF -y install gimp inkscape

# Unfortunately, I really need some sort of office
$DNF -y install libreoffice

