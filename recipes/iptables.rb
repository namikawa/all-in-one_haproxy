#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: iptables
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

# Spec(ToDo): allow src address filter only now.
%w{
  iptables
  ip6tables
}.each do |file|
  template "/etc/sysconfig/#{file}" do
    source "sysconfig/iptables.erb"
    mode 0600
    variables(
      :file => file
    )
  end

  service file do
    if !node["#{file}"].nil? and !node["#{file}"].size == 0
      action [ :enable, :start ]
    else
      action [ :disable, :stop ]
    end
  end
end

