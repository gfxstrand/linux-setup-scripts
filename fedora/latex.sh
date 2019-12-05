#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script installs my usual LaTeX environment.
#
# To be run as root.

DNF=${DNF-dnf}

# Install texlive
$DNF -y install texlive-latex

# Install latexmk
$DNF -y install perl-MD5 latexmk

# Install more LaTeX fonts
$DNF -y install texlive-collection-fontsrecommended \
                texlive-collection-fontsextra

# Install various aditional LaTeX packages
$DNF -y install texlive-sectsty texlive-diagmac2 texlive-amsrefs \
                texlive-moderncv texlive-beamer texlive-jknapltx \
                texlive-xetex texlive-mathspec texlive-euenc

