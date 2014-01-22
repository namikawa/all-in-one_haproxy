#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: default
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

directory "/tmp/rpms" do
  recursive true
end

include_recipe "all-in-one_haproxy::mkswap"

