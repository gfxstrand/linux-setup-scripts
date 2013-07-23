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

sudo apt-get install rubygems ruby-dev pandoc python-pygments

gem install nanoc adsf
gem install pandoc-ruby
gem install nokogiri pygments.rb

