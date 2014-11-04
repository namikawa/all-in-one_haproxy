#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: snmpd
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

%w{
  net-snmp
  net-snmp-perl
}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/snmp/snmpd.conf" do
  source "snmp/snmpd.conf.erb"
  mode 0644
  notifies :restart, "service[snmpd]"
end

cookbook_file "/etc/snmp/haproxy.pl" do
  source "haproxy.pl"
  mode 0755
end

service "snmpd" do
  action [ :enable, :start ]
end

