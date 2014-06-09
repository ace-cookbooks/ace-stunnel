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
end

ruby_block 'ensure stunnel started' do
  block do
    true
  end
  notifies :start, 'eye_service[stunnel]', :immediately
end
