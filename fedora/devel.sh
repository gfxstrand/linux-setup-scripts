#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for Wayland development.
#
# To be run as root.

# Install basic tools for software development
$YUM -y group install "Development Tools"

# Install other development tools
$YUM -y install gdb valgrind strace clang gcc-c++ tig

# Install autotools and CMake
$YUM -y install automake autoconf libtool cmake

# This is for submitting patches
$YUM -y install git-email

