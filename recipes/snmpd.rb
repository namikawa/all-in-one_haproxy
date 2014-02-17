#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: snmpd
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

template "/etc/snmp/snmpd.conf" do
  source "snmp/snmpd.conf.erb"
  mode 0644
end

service "snmpd" do
  action [ :enable, :restart ]
end

