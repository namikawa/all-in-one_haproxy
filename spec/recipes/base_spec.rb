require_relative '../spec_helper'

describe 'all-in-one_haproxy::base' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  %w{
    sysstat
    dstat
    mosh
  }.each do |p|
    it "install #{p}" do
      expect(chef_run).to install_package p
    end
  end

  it 'configure hosts' do
    expect(chef_run).to render_file('/etc/hosts').with_content('192.168.235.61  peer')
  end

  it 'configure sysctl' do
    expect(chef_run).to render_file('/etc/sysctl.conf').with_content('net.ipv4.ip_local_port_range')
  end

  it 'configure limits.conf' do
    expect(chef_run).to render_file('/etc/security/limits.conf').with_content('*       soft    nofile  65536')
    expect(chef_run).to render_file('/etc/security/limits.conf').with_content('*       hard    nofile  65536')
  end
end

