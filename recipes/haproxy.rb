#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: haproxy
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#
package_localrpm("haproxy", "haproxy-1.5_dev21-2.x86_64.rpm")

directory "/var/lib/haproxy" do
  mode 0755
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy/haproxy.cfg.erb"
  mode 0644
end

service "haproxy" do
  action [ :disable, :stop ]
end

