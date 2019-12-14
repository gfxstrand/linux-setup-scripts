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

# We need RPMFusion
`dirname $0`/rpmfusion.sh

# Install the nvidia driver
$DNF -y install akmod-nvidia

# Install the modprobe and udev config files
cp nvidia-pm.conf /etc/modprobe.d/
cp 80-nvidia-pm.rules /etc/udev/rules.d/

# Run dracut to ensure the new config files end up in initrd
dracut --force --regenerate-all --install /etc/modprobe.d/nvidia-pm.conf \
       --install /etc/udev/rules.d/80-nvidia-pm.rules
