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
default['haproxy']['global']['log'] = "127.0.0.1 local2"
default['haproxy']['global']['chroot'] = "/var/lib/haproxy"
default['haproxy']['global']['pid'] = "/var/run/haproxy.pid"
default['haproxy']['global']['user'] = "nobody"
default['haproxy']['global']['group'] = "nobody"
default['haproxy']['global']['maxconn'] = "60000"
default['haproxy']['global']['nbproc'] = "2"
default['haproxy']['global']['stats']['socket'] = "/var/run/haproxy.sock level user"
default['haproxy']['global']['stats']['timeout'] = "10s"

default['haproxy']['defaults']['mode'] = "tcp"
default['haproxy']['defaults']['log'] = "global"
default['haproxy']['defaults']['retries'] = "3"
default['haproxy']['defaults']['timeout']['queue'] = "1m"
default['haproxy']['defaults']['timeout']['connect'] = "10s"
default['haproxy']['defaults']['timeout']['client'] = "8h"
default['haproxy']['defaults']['timeout']['server'] = "8h"
default['haproxy']['defaults']['timeout']['check'] = "10s"

default['haproxy']['backend']['mysql'] = {
  "name" => "mysql-slave",
  "mode" => "tcp",
  "balance" => "roundrobin",
  "option" => [
    "mysql-check user root",
  ],
  "server" => [
    "db01 db01:3306 weight 10 check port 3306 inter 3000 fall 2",
    "db02 db02:3306 weight 10 check port 3306 inter 3000 fall 2",
    "db03 db03:3306 weight 10 check port 3306 inter 3000 fall 2",
  ],
}

default['haproxy']['frontend']['mysql'] = {
  "name" => "mysql",
  "bind_port" => "3306",
  "bind_option" => "",
  "mode" => "tcp",
  "default_backend" => default['haproxy']['backend']['mysql']['name'],
}

default['haproxy']['stats']['bind'] = "ipv4@:3000"
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

##### snmpd
default['snmpd']['sec']['community'] = "public"
default['snmpd']['sec']['source'] = [
  "10.32.0.0/12",
  "localhost",
]

##### quagga (zebra)
default['quagga']['password'] = "zebra"
default['quagga']['ospfd']['network'] = "10.1.255.0/28"

