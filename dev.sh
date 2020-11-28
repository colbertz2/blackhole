#!/bin/bash
#
# Set up development environment
#
# usage:
#       dev.sh          configure for dev
#       dev.sh -u       clean up for prod
#       dev.sh -h       print usage

EXE="$(realpath -mq ./blackhole)"
HOSTS="$(realpath -mq ./hosts)"
CONF="$(realpath -mq ./blackhole.conf)"

__usage() {
    >&2 echo "usage:"
    >&2 echo "    dev.sh        configure for dev"
    >&2 echo "    dev.sh -u     clean up for prod"
    >&2 echo "    dev.sh -h     print usage info"
    >&2 echo ""
    return 0
}

__dev() {
    # Set up fake system files in cwd
    echo "# Fake /etc/hosts file" >  $HOSTS
    echo "127.0.0.1    localhost" >> $HOSTS
    echo "127.0.0.1    my-pc"     >> $HOSTS

    grep "BLACKLIST_COMMENT=" $EXE | awk -F'[""]' '{print $2}' > $CONF

    # Replace hosts and blacklist path in script file
    sed -i "s|\${BLACKHOLE_HOSTS_FILE}|$HOSTS|" $EXE
    sed -i "s|\${BLACKHOLE_CONF_FILE}|$CONF|" $EXE

    return 0
}

__undev() {
    # Set script variables back the way they were
    sed -i "s|\${BLACKHOLE_HOSTS_FILE}|/etc/hosts|" $EXE
    sed -i "s|\${BLACKHOLE_CONF_FILE}|/usr/local/etc/blackhole.conf|" $EXE

    # Clean up fake files
    rm -f $HOSTS $CONF

    return 0
}

if [ "$1" = "-h" ]; then
    __usage
    exit $?
fi

if [ "$1" = "-u" ]; then
    __undev
    exit $?
fi

if [ $# -gt 0 ]; then
    >&2 echo "dev.sh: unrecognized argument '$1'"
    >&2 echo ""
    __usage
    exit 1
fi

__dev
exit $?