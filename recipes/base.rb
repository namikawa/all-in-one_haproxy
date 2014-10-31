#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: base
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

# package
%W{
  vim
  telnet
  tcpdump
  sysstat
  dstat
  mosh
}.each do |pkg|
  package pkg do
    action :install
  end
end

# hosts
template "/etc/hosts" do
  source "hosts.erb"
  mode "0644"
end

# sysctl
template "/etc/sysctl.conf" do
  source "sysctl.conf.erb"
  mode 0644
end

execute "sysctl -p" do
  command "/sbin/sysctl -p"
end

# limits.conf
template "/etc/security/limits.conf" do
  source "security/limits.conf.erb"
  mode 0644
end

