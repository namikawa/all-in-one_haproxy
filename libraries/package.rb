def package_localrpm(pkg, file)
  cookbook_file "/tmp/#{file}" do
    source file
    mode 0644
  end

  package pkg do
    action :install
    provider Chef::Provider::Package::Rpm
    source "/tmp/#{file}"
  end
end

