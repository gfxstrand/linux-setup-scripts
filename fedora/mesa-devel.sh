#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for Mesa development.
#
# To be run as root.

# Install devel stuff as well
`dirname $0`/devel.sh

# Install useful tools
$YUM -y install apitrace valgrind-devel

# Install the Vulkan loader
$YUM -y install vulkan-devel

# Dependencies for libdrm and intel-gpu-tools
$YUM -y install xorg-x11-util-macros kmod-devel procps-ng-devel \
                libunwind-devel

# Install mesa dependancies
$YUM builddep -y mesa
$YUM -y install python-mako expat-devel bison byacc flex nettle-devel \
                libdrm-devel systemd-devel libpciaccess-devel llvm-static \
                libwayland-client-devel libwayland-server-devel \
                libXrandr-devel libxshmfence-devel llvm-devel

# install 32-bit build depnedencies
$YUM builddep -y mesa-libGL.i686
$YUM -y install mesa-libwayland-egl-devel.i686 wayland-devel.i686 \
                libXext-devel.i686 libXdamage-devel.i686 \
                libXfixes-devel.i686 libXxf86vm-devel.i686 \
                libXrandr-devel.i686 wayland-protocols-devel \
                expat-devel.i686 valgrind-devel.i686

# Install piglit mesa dependancies
$YUM builddep -y piglit
$YUM -y install waffle-devel ninja-build mesa-libEGL-devel \
                mesa-libwayland-egl-devel mesa-libgbm-devel libcaca-devel \
                python3-numpy python3-simplejson python3-lxml \
                libxkbcommon-devel

# Install crucible mesa dependancies
$YUM -y install asciidoc libxml2-devel opencv-python
