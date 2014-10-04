#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for Wayland development.
#
# To be run as root.

# Install devel stuff as well
`dirname $0`/devel.sh

# Install mesa dependancies
yum-builddep -y mesa

# Install piglit mesa dependancies
yum-builddep -y piglit
yum -y install ninja-build mesa-libEGL-devel mesa-libgbm-devel

# Enable rendernodes and disable the command parser on boot
sed -i -e 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="\1 drm.rnodes=1 i915.enable_cmd_parser=0"/' /etc/default/grub

# Re-run grub to make the new options actually happen
if [ -L /etc/grub2-efi.cfg ]; then
    grub2-mkconfig -o /etc/grub2-efi.cfg
fi
if [ -L /etc/grub2.cfg ]; then
    grub2-mkconfig -o /etc/grub2.cfg
fi

