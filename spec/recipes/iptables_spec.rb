require_relative '../spec_helper'

describe 'all-in-one_haproxy::iptables dualstack' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge('all-in-one_haproxy::iptables') }

  it 'configure iptables' do
    expect(chef_run).to render_file('/etc/sysconfig/iptables').with_content('-A INPUT -s 192.168.233.120/32 -p tcp -m tcp --dport 3306 -j ACCEPT')
  end

  it 'configure ip6tables' do
    expect(chef_run).to render_file('/etc/sysconfig/ip6tables').with_content('-A INPUT -s FD00::100:1234/128 -p tcp -m tcp --dport 3306 -j ACCEPT')
  end

  it 'service iptables' do
    expect(chef_run).to enable_service('iptables')
    expect(chef_run).to start_service('iptables')
  end

  it 'service ip6tables' do
    expect(chef_run).to enable_service('ip6tables')
    expect(chef_run).to start_service('ip6tables')
  end
end

describe 'all-in-one_haproxy::iptables ipv4 only' do
  let (:chef_run) do
    chef_run = ChefSpec::Runner.new(platform:'centos', version:'6.4') do |node|
      node.set['ip6tables'] = ""
    end.converge('all-in-one_haproxy::iptables')
  end

  it 'configure iptables' do
    expect(chef_run).to render_file('/etc/sysconfig/iptables').with_content('-A INPUT -s 192.168.233.120/32 -p tcp -m tcp --dport 3306 -j ACCEPT')
  end

  it 'not configure ip6tables' do
    expect(chef_run).to_not create_file('/etc/sysconfig/ip6tables')
  end

  it 'service iptables' do
    expect(chef_run).to enable_service('iptables')
    expect(chef_run).to start_service('iptables')
  end

  it 'not service ip6tables' do
    expect(chef_run).to disable_service('ip6tables')
    expect(chef_run).to stop_service('ip6tables')
  end
end
