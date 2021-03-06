#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: keepalived
#
# Copyright 2014-2015, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

%w{
  libnl
  net-snmp
}.each do |pkg|
  package pkg do
    action :install
  end
end

package_localrpm("keepalived", "keepalived-1.2.19-1.x86_64.rpm")

%w{
  keepalived.conf
  virtual_address.conf
}.each do |file|
  template "/etc/keepalived/#{file}" do
    source "keepalived/#{file}.erb"
    mode 0600
    notifies :restart, "service[keepalived]"
  end
end

service "keepalived" do
  action [ :enable, :start ]
end

