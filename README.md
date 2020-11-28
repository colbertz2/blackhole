# blackhole
locally blackhole domains using /etc/hosts

## description
`blackhole` is a simple utility for making changes to the system hosts file. It blackholes domain names by setting them as loopback interfaces. Most features of this utility must be run as the root user.

Domains are stored in a separate _blacklist_ and inserted into the hosts file when the blackhole is enabled. While the blackhole is enabled, blacklisted domains cannot be resolved by local programs (like your browser). The blackhole can be enabled with the `on` command and disabled with the `off` command.

Domains can be added to or removed from the blacklist at any time. The hosts file is synchronized with the blacklist when the black hole is enabled. The `clear` command clears all domains from the blacklist. If the blackhole is enabled, domains are also cleared from the hosts file.

## install
```shell
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/colbertz2/blackhole/main/install.sh)"
```

## uninstall
```shell
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/colbertz2/blackhole/main/uninstall.sh)"
```

## usage
```
blackhole list              Prints the current blacklist
blackhole add <domain>      Adds domain to the blacklist
blackhole rm <domain>       Removes domain from the blacklist (exact match)
blackhole clear             Clears all entries from the blacklist
blackhole on                Enables the blackhole
blackhole off               Disables the blackhole
blackhole help              Prints usage info
```

## example
Start by adding a domain to the blacklist:
```shell
$ blackhole add www.facebook.com
```

Use the `list` command to see that it has been added to the blacklist:
```shell
$ blackhole list
www.facebook.com
```

Enable the blackhole to block the blacklisted domain:
```shell
$ blackhole on
```

## errors
Errors will print an error message. Exit values generally mean:
```
0   Success
1   Usage error (missing arguments)
2   File I/O or permissions error
```

## files
Blacklist is stored at `/etc/blackhole.conf`, which is created by the install script.

Enabling/disabling the blackhole modifies `/etc/hosts`, preserving the original contents.

