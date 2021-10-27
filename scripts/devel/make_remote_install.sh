#! /bin/bash
set -e

REBOOT="no"
if [ "$1" = "-r" ]; then
  REBOOT="yes"
  shift
fi

WORKTREE=`basename "$PWD"`
REMOTE=$1

INSTALL_SCRIPT="\
cd ~/projects/linux/${WORKTREE} && \
sudo make modules_install install"
REBOOT_SCRIPT="$INSTALL_SCRIPT && \
sudo systemctl reboot"
MODPROBE_SCRIPT="$INSTALL_SCRIPT && \
((sudo modprobe -r xe && sudo modprobe xe) || \
 sudo systemctl reboot)"

make -j8
rsync -avzHP . "$REMOTE:projects/linux/${WORKTREE}"

if [ "$REBOOT" = "yes" ]; then
  ssh $REMOTE "$REBOOT_SCRIPT"
else
  ssh $REMOTE "$MODPROBE_SCRIPT"
fi
