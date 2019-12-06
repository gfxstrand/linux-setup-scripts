#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up nginx in a very basic way to advertise
# user accounts.
#
# To be run as root.

DNF=${DNF-dnf}

# Install nginx
$DNF -y install nginx

# Install the nginx config file
cp nginx-user.conf /etc/nginx/nginx.conf

# Allow httpd to see homedirs
setsebool -P httpd_enable_homedirs true

# Make /home/jason readable
chmod o+r /home/jason

# Allow HTTP to go through the firewall
firewall-cmd --add-service=http
firewall-cmd --permanent --add-service=http

# Enable and start nginx
systemctl enable nginx.service
systemctl start nginx.service
