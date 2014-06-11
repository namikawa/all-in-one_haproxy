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

