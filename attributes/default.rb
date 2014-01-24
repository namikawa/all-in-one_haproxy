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

##### haproxy (for MySQL) #####
default['haproxy']['log'] = "127.0.0.1 local2"
default['haproxy']['chroot'] = "/var/lib/haproxy"
default['haproxy']['pid'] = "/var/run/haproxy.pid"
default['haproxy']['user'] = "nobody"
default['haproxy']['group'] = "nobody"
default['haproxy']['maxconn'] = "60000"
default['haproxy']['nbproc'] = "2"

default['haproxy']['defaults']['mode'] = "tcp"
default['haproxy']['defaults']['retries'] = "3"
default['haproxy']['defaults']['to_queue'] = "1m"
default['haproxy']['defaults']['to_connect'] = "10s"
default['haproxy']['defaults']['to_client'] = "8h"
default['haproxy']['defaults']['to_server'] = "8h"
default['haproxy']['defaults']['to_check'] = "10s"

default['haproxy']['backend']['1'] = {
  "name" => "mysql-slave",
  "mode" => "tcp",
  "balance" => "roundrobin",
  "server" => [
    "db01 db01:3306 weight 10 check port 3306 inter 3000 fall 2",
    "db02 db02:3306 weight 10 check port 3306 inter 3000 fall 2",
    "db03 db03:3306 weight 10 check port 3306 inter 3000 fall 2",
  ],
}

default['haproxy']['frontend']['1'] = {
  "name" => "mysql",
  "bind_port" => "3306",
  "mode" => "tcp",
  "default_backend" => default['haproxy']['backend']['1']['name'],
}

default['haproxy']['stats']['bind'] = "ipv6@:3000"
default['haproxy']['stats']['uri'] = "/"

##### keepalived #####
default['keepalived']['peer'] = "127.0.0.1"
default['keepalived']['virtual_ipaddress']['1'] = [
  "127.0.0.1",
  "::1",
]

default['keepalived']['interface'] = "eth0"
default['keepalived']['virtual_router_id'] = "200"
default['keepalived']['advert_int'] = "1"
default['keepalived']['auth_pass'] = "DJc9kI1n"

