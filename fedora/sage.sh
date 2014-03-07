#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the dependancies required to build and run
# the SAGE mathematical software.
#
# To be run as root.

# Install atlas
yum -y install atlas-devel

# Install ExtUtils::MakeMaker.  This is needed to build git.
yum -y install perl-ExtUtils-MakeMaker

