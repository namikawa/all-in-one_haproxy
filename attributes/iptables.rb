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

