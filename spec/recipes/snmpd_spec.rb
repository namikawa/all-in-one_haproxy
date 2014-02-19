require_relative '../spec_helper'

describe 'all-in-one_haproxy::snmpd' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  %w{
    net-snmp
    net-snmp-perl
  }.each do |p|
    it "install #{p}" do
      expect(chef_run).to install_package p
    end
  end

  it 'install snmpd' do
    expect(chef_run).to install_package 'net-snmp'
  end

  it 'configure snmpd' do
    expect(chef_run).to render_file('/etc/snmp/snmpd.conf').with_content('com2sec notConfigUser  10.32.0.0/12  public')
  end

  it 'configure snmpd for haproxy' do
    expect(chef_run).to render_file('/etc/snmp/haproxy.pl')
  end

  it 'service snmpd' do
    expect(chef_run).to enable_service('snmpd')
    expect(chef_run).to restart_service('snmpd')
  end
end

