#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: haproxy
#
# Copyright 2014-2015, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#
package_localrpm("haproxy", "haproxy-1.5.14-1.x86_64.rpm")

directory "/var/lib/haproxy" do
  mode 0755
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy/haproxy.cfg.erb"
  mode 0644
  notifies :reload, "service[haproxy]"
end

template "/etc/haproxy/server.pem" do
  source "haproxy/server.pem.erb"
  mode 0600
  notifies :reload, "service[haproxy]"
end

service "haproxy" do
  action :disable
  reload_command "/sbin/service haproxy reload"
end

