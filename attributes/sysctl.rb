##### sysctl #####
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

