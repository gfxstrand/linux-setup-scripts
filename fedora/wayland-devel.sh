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

# Install wayland build dependancies
yum -y install libffi-devel expat-devel

# Install xkbcommon build dependancies
yum -y install xorg-x11-util-macros byacc

# Install Mesa build dependancies
yum -y install llvm-devel

# Install weston build dependancies
yum -y install libX11-devel libXext-devel libxcb-devel libXcursor-devel\
        libxkbcommon-devel
yum -y install mesa-libEGL-devel mesa-libGL-devel mesa-libGLES-devel\
        mesa-libgbm-devel mesa-libwayland-egl-devel
yum -y install mtdev-devel pam-devel
yum -y install libjpeg-devel cairo-devel

# Install FreeRDP build dependancies
yum -y install zlib-devel openssl-devel

# Install dependancies for wayland-java
yum -y install maven

