#!/bin/busybox sh

export GUIX_NEW_SYSTEM=$(/bin/busybox readlink -f /var/guix/profiles/system)
# $GUIX_NEW_SYSTEM/boot needs this to exist even though /run is expected to be empty.
# I installed GuixSD in a proper VM and /run is not on tmpfs, so I'm not sure.
/bin/busybox ln -s none /run/current-system
setsid /var/guix/profiles/system/profile/bin/guile --no-auto-compile $GUIX_NEW_SYSTEM/boot >/dev/null &

/bin/busybox sleep 3
source /etc/profile

# why are these permissions not there in the first place?
for f in ping su sudo; do
        chmod 4755 $(readlink -f $(which $f))
done

# Setting up WSLg
if [ -d "/mnt/wslg" ]; then
        rm -r /tmp/.X11-unix
        ln -s /mnt/wslg/.X11-unix /tmp/.X11-unix
        # Add "export DISPLAY=:0" in your .bashrc!
fi

su -l root
