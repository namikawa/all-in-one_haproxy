require_relative '../spec_helper'

describe 'all-in-one_haproxy::lsyncd' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  %w{
    rsync
    xinetd
    lsyncd
  }.each do |p|
    it "install #{p}" do
      expect(chef_run).to install_package p
    end
  end

  it 'configure rsyncd' do
    expect(chef_run).to render_file('/etc/xinetd.d/rsync').with_content('disable         = no')
    expect(chef_run).to render_file('/etc/rsyncd.conf')
  end

  it 'service xinetd' do
    expect(chef_run).to enable_service('xinetd')
    expect(chef_run).to start_service('xinetd')
  end

  it 'configure lsyncd' do
    expect(chef_run).to render_file('/etc/lsyncd.conf')
  end

  it 'not service lsyncd' do
    expect(chef_run).to disable_service('lsyncd')
  end
end

