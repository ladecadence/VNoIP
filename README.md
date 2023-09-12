# VNoIP

Simple NoIP.com update client written in [V language](https://github.com/vlang/v)

## Usage

```
./vnoip -c <config file> [-t]

```

The optional __-t__ parameter does a dry run, doesn't send the updates to No-IP and is just used to check the config file. 

## Configuration 

_VNoIP_ expects a configuration file in _TOML_ with the following structure:

```
[[hosts]]
    update_url = "https://dynupdate.no-ip.com/nic/update"
    username = "user@email.con"
    password = "SecretPASSWD"
    hostname = "hostname.noip.com"
    offline = "NO"
[[hosts]]
    update_url = "https://dynupdate.no-ip.com/nic/update"
    username = "user2@webmail.con"
    password = "SuperSecret"
    hostname = "otherhost.noip.com"
    ip = "1.2.3.4"
    offline = "YES"
```

The configuration file can contain several __[[hosts]]__ sections, each one with the update_url (always the same for No-IP.com hosts) and the user credentials and the hostname to update. An optional _ip_ field can be used to specify an IP address to set the hostname to (if not No-IP will use the ip address of the request). It also contains an _offline_ parameter that sets the No-Ip.com offline status of the hostname. 

The program can then be called from _Cron_ or _systemd/Timers_ to update the host(s) periodically.

## Build and Install

* Requisites: V Language

Clone the repository

```
$ git clone https://github.com/ladecadence/VNoIP.git
```

And build it
```
$ cd VNoIP
$ v .
```

Then copy and edit the example config file to suit your needs.


## License

VNoIP is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See LICENSE.

VNoIP is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
