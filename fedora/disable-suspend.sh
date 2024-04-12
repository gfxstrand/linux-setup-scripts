#! /bin/bash
# Fedora setup script for Fedora >= 38
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script disables suspend on AC power
#
# To be run as root.

sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
