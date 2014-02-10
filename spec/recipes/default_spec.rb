require_relative '../spec_helper'

describe 'all-in-one_haproxy::default' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  %w{
    sysstat
    dstat
    mosh
    net-snmp
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

  it 'configure snmpd' do
    expect(chef_run).to render_file('/etc/snmp/snmpd.conf').with_content('com2sec notConfigUser  10.32.0.0/12  public')
  end

  it 'service snmpd' do
    expect(chef_run).to enable_service('snmpd')
    expect(chef_run).to restart_service('snmpd')
  end
end
