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
  notifies :restart, "service[xinetd]"
end

template "/etc/rsyncd.conf" do
  source "rsyncd.conf.erb"
  mode 0644
  notifies :restart, "service[xinetd]"
end

service "xinetd" do
  action [ :enable, :start ]
end

# lsyncd
package_localrpm("lsyncd", "lsyncd-2.1.4-4.el6.x86_64.rpm")

template "/etc/lsyncd.conf" do
  source "lsyncd.conf.erb"
  mode 0644
end

service "lsyncd" do
  action [ :disable, :stop ]
end

