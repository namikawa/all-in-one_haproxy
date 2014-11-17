require_relative '../spec_helper'

describe 'all-in-one_haproxy::quagga' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }

  it "install quagga" do
    expect(chef_run).to install_package("quagga")
  end

  it "configure zebra.conf" do
    expect(chef_run).to render_file('/etc/quagga/zebra.conf').with_content("password zebra")
  end

  it "configure ospfd.conf" do
    expect(chef_run).to render_file('/etc/quagga/ospfd.conf').with_content("redistribute connected")
  end

  it 'service zebra' do
    expect(chef_run).to enable_service('zebra')
    expect(chef_run).to start_service('zebra')
  end
  it 'service ospfd' do
    expect(chef_run).to enable_service('ospfd')
    expect(chef_run).to start_service('ospfd')
  end
end

