require_relative '../spec_helper'

describe 'all-in-one_haproxy::snmpd' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  it 'configure snmpd' do
    expect(chef_run).to render_file('/etc/snmp/snmpd.conf').with_content('com2sec notConfigUser  10.32.0.0/12  public')
  end

  it 'service snmpd' do
    expect(chef_run).to enable_service('snmpd')
    expect(chef_run).to restart_service('snmpd')
  end
end

