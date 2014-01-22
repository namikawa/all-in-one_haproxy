#
# Cookbook Name:: all-in-one_haproxy
# Recipe:: mkswap
#
# Copyright 2014, Yuuki NAMIKAWA
#
# All rights reserved - Do Not Redistribute
#

directory "/var/swap" do
  mode 0755
end

script 'create swap-file' do
  interpreter 'bash'
  not_if { File.exists?('/var/swap/swap-file') }
  code <<-EOF
    dd if=/dev/zero of=/var/swap/swap-file bs=1M count=2048 &&
    chmod 600 /var/swap/swap-file &&
    mkswap /var/swap/swap-file
  EOF
end

mount '/dev/null' do  # swap file entry for fstab
  action :enable  # cannot mount; only add to fstab
  device '/var/swap/swap-file'
  fstype 'swap'
end

script 'activate swap' do
  interpreter 'bash'
  code 'swapon -ae'
end

