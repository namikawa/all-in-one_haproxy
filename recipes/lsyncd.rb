#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: lsyncd
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

# rsync + xinetd
%W{
  rsync
  xinetd
}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/xinetd.d/rsync" do
  source "xinetd.d/rsync.erb"
  mode 0644
end

template "/etc/rsyncd.conf" do
  source "rsyncd.conf.erb"
  mode 0644
end

service "xinetd" do
  action [ :enable, :restart ]
end

# lsyncd
filename = "lsyncd-2.1.4-1.el6.rf.x86_64.rpm"

cookbook_file "/tmp/#{filename}" do
  source filename
  mode 0644
end

package "lsyncd" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end 

template "/etc/lsyncd.conf" do
  source "lsyncd.conf.erb"
  mode 0644
end

