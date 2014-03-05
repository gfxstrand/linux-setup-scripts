#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up a local proxy server on the machine.
#
# To be run as root.

# Install squid
yum -y install squid

cp `dirname $0`/squid.conf /etc/squid/

# Enable squid
systemctl start squid
systemctl enable squid
