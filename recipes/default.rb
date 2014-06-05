include_recipe 'simply-stunnel'
include_recipe 'ace-eye'

node['ace-stunnel']['files'].each do |name, contents|
  template "/etc/stunnel/#{name}" do
    source 'pem.erb'
    mode 0600
    owner 'root'
    group 'root'
    variables({
      contents: contents
    })
  end
end

directory node['stunnel']['global']['pid'] do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

directory node['stunnel']['global']['output'] do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

eye_app 'stunnel' do
  template 'eye-stunnel.conf.erb'
  cookbook 'ace-stunnel'
end
