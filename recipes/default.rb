chef_gem 'chef-rewind'
require 'chef/rewind'

include_recipe 'simply-stunnel'
include_recipe 'ace-eye'

node['ace-stunnel']['files'].each do |name, contents|
  template "/etc/stunnel/#{name}" do
    source 'pem.erb'
    mode 0600
    owner node['stunnel']['user']
    group node['stunnel']['user']
    variables({
      contents: contents
    })
  end
end

directory '/var/run/stunnel' do
  owner node['stunnel']['user']
  group node['stunnel']['user']
  mode 00755
  action :create
end

directory '/var/log/stunnel' do
  owner node['stunnel']['user']
  group node['stunnel']['user']
  mode 00755
  action :create
end

eye_app 'stunnel' do
  template 'eye-stunnel.conf.erb'
  cookbook 'ace-stunnel'
  restart_timing :immediately
end

if node[:opsworks][:activity] != 'setup'
  rewind 'template[/etc/stunnel/stunnel.conf]' do
    notifies :restart, 'eye_service[stunnel]', :immediately
  end
end
