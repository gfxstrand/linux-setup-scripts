#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for Wayland development.
#
# To be run as root.

DNF=${DNF-dnf}

# Install basic tools for software development
$DNF -y group install "Development Tools"

# This is needed for building some things.  I have no idea why.
$DNF -y redhat-rpm-config

# Install other development tools
$DNF -y install gdb valgrind strace ccache clang gcc-c++ tig

# Install autotools and CMake
$DNF -y install automake autoconf libtool cmake

# This is for submitting patches
$DNF -y install git-email

