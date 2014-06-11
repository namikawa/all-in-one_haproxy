##### rsyncd + lsyncd #####
default['xinetd']['rsync']['disable'] = "no"
default['xinetd']['rsync']['user'] = "root"
default['xinetd']['rsync']['server'] = "/usr/bin/rsync"
default['xinetd']['rsync']['server_args'] = "--daemon"

default['rsyncd']['log'] = "/var/log/rsyncd.log"
default['rsyncd']['pid'] = "/var/run/rsyncd.pid"

default['lsyncd']['log'] = "/var/log/lsyncd.log"
default['lsyncd']['status'] = "/tmp/lsyncd.stat"
default['lsyncd']['interval'] = "1"

