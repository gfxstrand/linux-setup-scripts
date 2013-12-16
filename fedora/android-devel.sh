#! /bin/bash
# Fedora setup script for Fedora >= 19
#
# This set of scripts sets up a new fedora install to my personal tastes
# including default software installs, shell configuration, etc.
#
# This particular script sets up the machine for Android development both
# in terms of app development and also for building the full Android tree.
#
# To be run as root.

# Install devel stuff as well
`dirname $0`/devel.sh

ORACLE_JAVA_PATH=/home/jason/Downloads
ORACLE_JAVA_VERSION=6u45

# Install my a udev rule for android USB devices
cp `dirname $0`/51-android.rules /etc/udev/rules.d/

# Install OpenJDK
yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel

# Install tools required for building apps
yum -y install ant

# Install tools required for building the Android OS
yum -y install bison flex gperf ccache

# Install Oracle Java6 JRE and JDK
sh ${ORACLE_JAVA_PATH}/jre-${ORACLE_JAVA_VERSION}-linux-x64-rpm.bin
sh ${ORACLE_JAVA_PATH}/jdk-${ORACLE_JAVA_VERSION}-linux-x64-rpm.bin

# Set up alternatives for "java" and "javac"
JAVA_SLAVES=""
for file in `ls /usr/java/default/jre/bin`; do
    if [ -h /usr/bin/$file -a $file != java ]; then
        JAVA_SLAVES="$JAVA_SLAVES --slave /usr/bin/$file $file \
                /usr/java/default/jre/bin/$file"
    fi
done
alternatives --install /usr/bin/java java /usr/java/default/jre/bin/java \
        10000 $JAVA_SLAVES

JAVAC_SLAVES=""
for file in `ls /usr/java/default/bin`; do
    if [ -h /usr/bin/$file -a $file != javac ]; then
        if [ -e /usr/java/default/jre/bin/$file ]; then
            continue
        fi
        JAVAC_SLAVES="$JAVAC_SLAVES --slave /usr/bin/$file $file \
                /usr/java/default/bin/$file"
    fi
done
alternatives --install /usr/bin/javac javac /usr/java/default/bin/javac \
        10000 $JAVAC_SLAVES

