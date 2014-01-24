#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: haproxy
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

filename = "haproxy-1.5_dev21-1.x86_64.rpm"

cookbook_file "/tmp/#{filename}" do
  source filename
  mode 0644
end

package "haproxy" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy/haproxy.cfg.erb"
  mode 0644
end

