#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the nvidia proprietary drivers and
# configures them for proper power management.
#
# To be run as root.

DNF=${DNF-dnf}

# We need RPMFusion for dptfxtract
`dirname $0`/rpmfusion.sh

# Install the nvidia driver
$DNF -y install thermald dptfxtract

systectl enable thermald
systectl start dptfxtract
