#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the basics of the user account such as my
# shell and text editor.
#
# To be run as root.

# Install texlive
yum -y install texlive-latex

# Install latexmk
yum -y install perl-MD5 latexmk

# Install various aditional LaTeX packages
yum -y install texlive-diagmac2 texlive-amsrefs

