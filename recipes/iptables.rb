#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: iptables
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

# ToDo: src filter only now.
template "/etc/sysconfig/iptables" do
  source "sysconfig/iptables.erb"
  mode 0600
end

service "keepalived" do
  action [ :enable, :start ]
end

