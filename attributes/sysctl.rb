##### sysctl #####

### kernel
default['sysctl']['kernel'] = {
  "core_uses_pid" => "0",
  "msgmnb" => "65536",
  "msgmax" => "65536",
  "shmmax" => "68719476736",
  "shmall" => "4294967296",
  "sem" => "250 32000 96 128",
  "panic" => "60",
  "sysrq" => "1",
}

### vm
default['sysctl']['vm']['swappiness'] = "10"

### net.ipv4
default['sysctl']['net']['ipv4'] = {
  "ip_forward" => "0",
  "tcp_syncookies" => "1",
  "icmp_ignore_bogus_error_responses" => "1",
  "tcp_rmem" => "4096 87380 1048576",
  "tcp_wmem" => "4096 16384 1048576",
  "tcp_mem" => "1048576 1048576 1048576",
  "ip_local_port_range" => "3500 65535",
}

default['sysctl']['net']['ipv4']['conf']['default'] = {
  "rp_filter" => "1",
  "accept_source_route" => "0",
}

default['sysctl']['net']['ipv4']['conf']['all']['log_martians'] = "1"

### net.core
default['sysctl']['net']['core'] = {
  "somaxconn" => "1024",
  "netdev_max_backlog" => "2048",
  "rmem_max" => "1048576",
  "wmem_max" => "1048576",
  "rmem_default" => "1048576",
  "wmem_default" => "1048576",
  "optmem_max" => "20480",
}

### other (extend parameters)
default['sysctl']['extend_params'] = []

