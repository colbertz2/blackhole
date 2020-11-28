#!/bin/sh

if [ $EUID -ne 0 ]; then
    >&2 echo "Please run as root!"
    exit 1
fi

FILE_LIST="
/usr/local/bin/blackhole
/usr/local/man/man1/blackhole.1.gz
/usr/local/share/blackhole
/usr/local/etc/blackhole.conf
"

rm -rf $FILE_LIST