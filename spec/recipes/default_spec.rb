require_relative '../spec_helper'

describe 'all-in-one_haproxy::default' do
  let (:chef_run) { ChefSpec::Runner.new(platform:'centos', version:'6.4').converge(described_recipe) }
end

