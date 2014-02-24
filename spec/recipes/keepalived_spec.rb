require_relative '../spec_helper'

describe 'all-in-one_haproxy::keepalived' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  %w{
    libnl
    net-snmp
    keepalived
  }.each do |p|
    it "install #{p}" do
      expect(chef_run).to install_package p
    end
  end

  it 'configure keepalived.conf' do
    expect(chef_run).to render_file('/etc/keepalived/keepalived.conf').with_content('192.168.235.61 dev eth0')
    expect(chef_run).to render_file('/etc/keepalived/keepalived.conf').with_content('include /etc/keepalived/virtual_address.conf')
  end

  it 'configure virtual_address.conf' do
        expect(chef_run).to render_file('/etc/keepalived/virtual_address.conf').with_content('192.168.235.210/32 dev eth0')
        expect(chef_run).to render_file('/etc/keepalived/virtual_address.conf').with_content('FD00::1234/128 dev eth0')
  end

  it 'service keepalived' do
    expect(chef_run).to enable_service('keepalived')
    expect(chef_run).to restart_service('keepalived')
  end
end

