#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: keepalived
#
# Copyright 2014, Yuuki NAMIKAWA
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

filename = "keepalived-1.2.10-1.x86_64.rpm"

cookbook_file "/tmp/#{filename}" do
  source filename
  mode 0644
end

package "keepalived" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end

%w{
  keepalived.conf
  virtual_address.conf
}.each do |file|
  template "/etc/keepalived/#{file}" do
    source "keepalived/#{file}.erb"
    mode 0600
  end
end

service "keepalived" do
  action [ :enable, :restart ]
end

