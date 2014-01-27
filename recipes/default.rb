#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: default
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

# package
%W{
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
cookbook_file "/etc/sysctl.conf" do
  source "sysctl.conf"
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

# include recipe
include_recipe "all-in-one_haproxy::mkswap"
include_recipe "all-in-one_haproxy::lsyncd"
include_recipe "all-in-one_haproxy::haproxy"
include_recipe "all-in-one_haproxy::keepalived"
include_recipe "all-in-one_haproxy::iptables"

