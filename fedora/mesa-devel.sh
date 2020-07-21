#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for Mesa development.
#
# To be run as root.

DNF=${DNF-dnf}

# Install devel stuff as well
`dirname $0`/devel.sh

# Install useful tools
$DNF -y install apitrace valgrind-devel rlwrap

# Install the Vulkan loader
$DNF -y install vulkan-devel vulkan-tools

# Dependencies for libdrm and intel-gpu-tools
$DNF -y install xorg-x11-util-macros kmod-devel procps-ng-devel \
                libunwind-devel

# Install mesa dependancies
$DNF builddep -y mesa
$DNF -y install python-mako expat-devel bison byacc flex nettle-devel \
                libdrm-devel systemd-devel libpciaccess-devel llvm-static \
                libwayland-client-devel libwayland-server-devel \
                wayland-protocols-devel libXxf86vm-devel libXfixes-devel \
                libXdamage-devel libXrandr-devel libxshmfence-devel llvm-devel

# install 32-bit build depnedencies
$DNF builddep -y mesa-libGL.i686
$DNF -y install glibc-devel.i686 expat-devel.i686 \
                mesa-libwayland-egl-devel.i686 wayland-devel.i686 \
                libX11-devel.i686 libXext-devel.i686 libXdamage-devel.i686 \
                libXfixes-devel.i686 libXxf86vm-devel.i686 \
                libXrandr-devel.i686 libxcb-devel.i686 xshmfence-devel.i686 \
                libwayland-devel.i686 \
                expat-devel.i686 valgrind-devel.i686

# Install piglit mesa dependancies
$DNF builddep -y piglit
$DNF -y install waffle-devel ninja-build mesa-libEGL-devel \
                mesa-libwayland-egl-devel mesa-libgbm-devel libcaca-devel \
                python3-numpy python3-simplejson python3-lxml \
                libxkbcommon-devel libcaca-devel

# Install crucible mesa dependancies
$DNF -y install asciidoc libxml2-devel python3-opencv

# Install shader-db dependancies
$DNF -y install python3-scipy python3-attrs

# Install Vulkan CTS
$DNF -y install mesa-libGLES-devel libSM-devel \
                mesa-libGL-devel.i686 mesa-libGLES-devel.i686 \
                valgrind-devel.i686 libpng-devel.i686

# Install RenderDoc dependencies
$DNF -y install python3-devel qt5-devel xcb-util-keysyms-devel
