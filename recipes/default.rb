#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: default
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

# include recipe
include_recipe "all-in-one_haproxy::base"
include_recipe "all-in-one_haproxy::snmpd"
include_recipe "all-in-one_haproxy::mkswap"
include_recipe "all-in-one_haproxy::lsyncd"
include_recipe "all-in-one_haproxy::haproxy"
include_recipe "all-in-one_haproxy::keepalived"
include_recipe "all-in-one_haproxy::iptables"
#include_recipe "all-in-one_haproxy::quagga"

