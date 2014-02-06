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

default['haproxy']['backend']['mysql'] = {
  "name" => "mysql-slave",
  "mode" => "tcp",
  "balance" => "roundrobin",
  "server" => [
    "db01 db01:3306 weight 10 check port 3306 inter 3000 fall 2",
    "db02 db02:3306 weight 10 check port 3306 inter 3000 fall 2",
    "db03 db03:3306 weight 10 check port 3306 inter 3000 fall 2",
  ],
}

default['haproxy']['frontend']['mysql'] = {
  "name" => "mysql",
  "bind_port" => "3306",
  "mode" => "tcp",
  "default_backend" => default['haproxy']['backend']['mysql']['name'],
}

default['haproxy']['stats']['bind'] = "ipv6@:3000"
default['haproxy']['stats']['uri'] = "/"

##### keepalived #####
default['keepalived']['peer'] = "192.168.235.61"
default['keepalived']['virtual_ipaddress']['mysql'] = [
  "192.168.235.210",
  "FD00::1234",
]

default['keepalived']['interface'] = "eth0"
default['keepalived']['virtual_router_id'] = "200"
default['keepalived']['advert_int'] = "1"
default['keepalived']['auth_pass'] = "DJc9kI1n"

##### limits.conf #####
default['limits']['root']['soft_nofile'] = "65536"
default['limits']['root']['hard_nofile'] = "65536"
default['limits']['root']['soft_stack'] = "65536"
default['limits']['root']['hard_stack'] = "65536"
default['limits']['all']['soft_nofile'] = "65536"
default['limits']['all']['hard_nofile'] = "65536"
default['limits']['all']['soft_stack'] = "65536"

##### iptables & ip6tables #####
default['iptables']['allow']['src']['mysql'] = {
  "dport" => "3306",
  "address" => [
    "192.168.233.120/32",
    "192.168.234.120/32",
  ],
}

default['ip6tables']['allow']['src']['mysql'] = {
  "dport" => "3306",
  "address" => [
    "FD00::100:1234/128",
    "FD00::101:1234/128",
  ],
}

##### snmpd
default['snmpd']['sec']['community'] = "public"
default['snmpd']['sec']['source'] = [
  "10.32.0.0/12",
  "localhost",
]

