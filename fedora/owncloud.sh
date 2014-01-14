#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the ownCloud personal cloud system
#
# To be run as root.

# NOTE:
# Once the script completes, SELinux will have to be temporaraly disabled
# and the system rebooted in order to run the configuration.  Once the
# configuration process is completed, SELinux can be safely re-enabled.
#
# Also, it is recommended that you edit the apache user crontab and add the
# following line:
# */15  *  *  *  * php -f /var/www/html/owncloud/cron.php

# Figure out our Fedora version
VERSION_ID=`source /etc/os-release; echo \$VERSION_ID`

# Set up the proper SELinux contexts.  Supposidly, the owncloud packages
# will do this, but they tend to be broken.
semanage fcontext -a -r s0 -t httpd_sys_rw_content_t '/var/www/html/owncloud/apps(/.*)?'
semanage fcontext -a -r s0 -t httpd_sys_rw_content_t '/var/www/html/owncloud/config(/.*)?'
semanage fcontext -a -r s0 -t httpd_sys_rw_content_t '/var/www/html/owncloud/data(/.*)?'

# Install the ownCloud repository
wget -P /etc/yum.repos.d http://download.opensuse.org/repositories/isv:ownCloud:community/Fedora_${VERSION_ID}/isv:ownCloud:community.rep

# Install ownCloud
yum -y install owncloud

# Enable http through the firewall
firewall-cmd --add-service=http
firewall-cmd --permanent --add-service=http

# Enable and start httpd
systemctl enable httpd.service
systemctl start httpd.service
