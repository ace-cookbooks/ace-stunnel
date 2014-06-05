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

node.force_default['stunnel']['global']['foreground'] = 'no'
node.force_default['stunnel']['global']['pid'] = '/var/run/stunnel/stunnel.pid'
node.force_default['stunnel']['global']['output'] = '/var/log/stunnel/stunnel.log'
eye_app 'stunnel' do
  template 'eye-stunnel.conf.erb'
  cookbook 'ace-stunnel'
end
