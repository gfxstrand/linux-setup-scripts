# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This script sets up ThinkFan for my ThinkPad
#
# To be run as root.

yum -y install thinkfan cpufrequtils
cp `dirname $0`/thinkfan.conf /etc/
cp `dirname $0`/cpupower /etc/sysconfig/
systemctl enable thinkfan.service
systemctl enable cpupower.service

