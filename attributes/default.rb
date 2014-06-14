##### hosts
default['hosts']['extend_hosts'] = []

##### snmpd
default['snmpd']['sec']['community'] = "public"
default['snmpd']['sec']['source'] = [
  "10.32.0.0/12",
  "localhost",
]

##### quagga (zebra)
default['quagga']['password'] = "zebra"
default['quagga']['ospfd']['network'] = "10.1.255.0/28"

