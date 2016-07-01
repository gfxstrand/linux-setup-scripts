#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script installs my usual LaTeX environment.
#
# To be run as root.

# Install texlive
$YUM -y install texlive-latex

# Install latexmk
$YUM -y install perl-MD5 latexmk

# Install more LaTeX fonts
$YUM -y install texlive-collection-fontsrecommended \
                texlive-collection-fontsextra

# Install various aditional LaTeX packages
$YUM -y install texlive-sectsty texlive-diagmac2 texlive-amsrefs \
                texlive-moderncv texlive-beamer texlive-jknapltx

