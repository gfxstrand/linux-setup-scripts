#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the packages I need to connect to VPN etc.
# for my job.
#
# To be run as root.

# Install dependencies for setting up VPN
$YUM -y install tsocks python-PKI NetworkManager-openconnect-gnome
