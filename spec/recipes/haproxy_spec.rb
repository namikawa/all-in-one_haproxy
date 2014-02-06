require_relative '../spec_helper'

describe 'all-in-one_haproxy::haproxy' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  it "install haproxy" do
    expect(chef_run).to install_package("haproxy")
  end

  it 'create directory' do
    expect(chef_run).to create_directory("/var/lib/haproxy")
  end

  it 'configure haproxy.cfg' do
    expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content("bind        192.168.235.210:3306")
    expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content("bind        FD00::1234:3306")
    expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content("db02 db02:3306 weight 10 check port 3306 inter 3000 fall 2")
  end
end

