#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for e-mail via notmuch and vim
#
# To be run as root.

$YUM -y install isync msmtp notmuch notmuch-vim ruby-notmuch elinks \
        python2-notmuch python2-docopt
