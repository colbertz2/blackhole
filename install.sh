#!/bin/sh

if [ $EUID -ne 0 ]; then
    >&2 echo "Please run as root!"
    exit 1
fi

SCRIPT_DEST="/usr/local/bin"
MAN_DEST="/usr/local/man/man1"
README_DEST="/usr/local/share/blackhole"
LICENSE_DEST="$README_DEST"

HOSTS_FILE="/etc/hosts"
CONF_FILE="/usr/local/etc/blackhole.conf"

# Prep destination folders
mkdir -p "$SCRIPT_DEST"
mkdir -p "$MAN_DEST"
mkdir -p "$README_DEST"
mkdir -p "$LICENSE_DEST"

# Grab source files from GitHub
trap "rm -f blackhole blackhole.1.gz LICENSE.txt README.md" SIGINT
curl -o blackhole "https://raw.githubusercontent.com/colbertz2/blackhole/main/blackhole"
curl -o blackhole.1.gz "https://raw.githubusercontent.com/colbertz2/blackhole/main/blackhole.1.gz"
curl -o README.md "https://raw.githubusercontent.com/colbertz2/blackhole/main/README.md"
curl -o LICENSE.txt "https://raw.githubusercontent.com/colbertz2/blackhole/main/LICENSE.txt"

# Set up variables in blackhole script
sed -i "s|\${BLACKHOLE_HOSTS_FILE}|$HOSTS_FILE|" blackhole
sed -i "s|\${BLACKHOLE_CONF_FILE}|$CONF_FILE|" blackhole

# Install files
install blackhole $SCRIPT_DEST
cp blackhole.1.gz $MAN_DEST
cp README.md $README_DEST
cp LICENSE.txt $LICENSE_DEST

# Create empty conf file
echo "# Domain blacklist for blackhole CLI" > $CONF_FILE

# Clean up
rm -f blackhole blackhole.1.gz README.md LICENSE.txt

exit 0