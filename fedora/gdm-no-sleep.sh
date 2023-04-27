#! /bin/bash
# Fedora setup script for Fedora >= 38
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script disables automatic sleep in gdm
#
# https://gitlab.gnome.org/GNOME/gnome-control-center/-/issues/22
#
# To be run as root.

gdm dbus-launch gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
