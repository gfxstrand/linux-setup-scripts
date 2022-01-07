#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for Ruby and nanoc-based
# website development.
#
# To be run as the regular user.

DNF=${DNF-dnf}

sudo $DNF -y install pandoc python3-pygments python3-beautifulsoup4 \
                     python3-jinja2 python3-dateutils python3-yaml \
                     python3-feedgen
