#!/bin/sh

# Creating necessary folders
mkdir -p /root /etc/guix /tmp /var/run /run /home
chmod 1777 /tmp

# Adding guix workers
rm /etc/passwd
cat <<EOM >> /etc/passwd
root:x:0:0:root:/root:/bin/bash
guixbuilder01:x:999:999:Guix build user 01:/var/empty:/usr/sbin/nologin
guixbuilder02:x:998:999:Guix build user 02:/var/empty:/usr/sbin/nologin
guixbuilder03:x:997:999:Guix build user 03:/var/empty:/usr/sbin/nologin
guixbuilder04:x:996:999:Guix build user 04:/var/empty:/usr/sbin/nologin
guixbuilder05:x:995:999:Guix build user 05:/var/empty:/usr/sbin/nologin
guixbuilder06:x:994:999:Guix build user 06:/var/empty:/usr/sbin/nologin
guixbuilder07:x:993:999:Guix build user 07:/var/empty:/usr/sbin/nologin
guixbuilder08:x:992:999:Guix build user 08:/var/empty:/usr/sbin/nologin
guixbuilder09:x:991:999:Guix build user 09:/var/empty:/usr/sbin/nologin
guixbuilder10:x:990:999:Guix build user 10:/var/empty:/usr/sbin/nologin
EOM

rm /etc/group
cat <<EOM >> /etc/group
root:x:0:
guixbuild:x:999:guixbuilder01,guixbuilder02,guixbuilder03,guixbuilder04,guixbuilder05,guixbuilder06,guixbuilder07,guixbuilder08,guixbuilder09,guixbuilder10
EOM

# Adding services
cat <<EOM >> /etc/services
ftp-data        20/tcp
ftp             21/tcp
ssh             22/tcp                          # SSH Remote Login Protocol
domain          53/tcp                          # Domain Name Server
domain          53/udp
http            80/tcp          www             # WorldWideWeb HTTP
https           443/tcp                         # http protocol over TLS/SSL
ftps-data       989/tcp                         # FTP over SSL (data)
ftps            990/tcp
http-alt        8080/tcp        webcache        # WWW caching service
http-alt        8080/udp
EOM

# Adding Guix channels
cat <<EOM >> /etc/guix/channels.scm
    ;; Your guix channels here
EOM

# Preparing environment
cd /tmp
wget http://ftp.gnu.org/gnu/guix/guix-binary-1.3.0.x86_64-linux.tar.xz
tar -C / -xvJf /tmp/guix-binary-1.3.0.x86_64-linux.tar.xz
mkdir -p ~root/.config/guix
ln -sf /var/guix/profiles/per-user/root/current-guix ~root/.config/guix/current
GUIX_PROFILE="`echo ~root`/.config/guix/current"
source $GUIX_PROFILE/etc/profile
guix-daemon --build-users-group=guixbuild &
guix archive --authorize < /var/guix/profiles/per-user/root/current-guix/share/guix/ci.guix.gnu.org.pub

# Reconfiguring the system
guix system reconfigure --no-bootloader --no-grafts -L $(dirname $(readlink -f $1)) $1
