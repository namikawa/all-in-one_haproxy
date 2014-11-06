#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: quagga
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

package "quagga" do
  action :install
end

%w{
  zebra
  ospfd
}.each do |srv|
  template "/etc/quagga/#{srv}.conf" do
    source "quagga/#{srv}.conf.erb"
    user "quagga"
    group "quagga"
    mode 0640
    notifies :restart, "service[#{srv}]"
  end

  service srv do
    action [ :enable, :start ]
  end
end

