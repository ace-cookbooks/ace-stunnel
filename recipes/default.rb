include_recipe 'stunnel'

node.force_default[:stunnel][:delay] = 'yes'
node.force_default[:stunnel][:verify] = '2'

template '/etc/stunnel/redislabs.crt' do
  source 'pem.erb'
  mode 0600
  owner 'root'
  group 'root'
  variables({
    contents: node['ace-stunnel']['cert']
  })
end

template '/etc/stunnel/redislabs.key' do
  source 'pem.erb'
  mode 0600
  owner 'root'
  group 'root'
  variables({
    contents: node['ace-stunnel']['key']
  })
end

template '/etc/stunnel/redislabs_ca.pem' do
  source 'pem.erb'
  mode 0600
  owner 'root'
  group 'root'
  variables({
    contents: node['ace-stunnel']['cafile']
  })
end

node.force_default[:stunnel][:certificate_path] = '/etc/stunnel/redislabs.crt'
node.force_default[:stunnel][:key_path] = '/etc/stunnel/redislabs.key'
node.force_default[:stunnel][:ca_file] = '/etc/stunnel/redislabs_ca.pem'

stunnel_connection 'redis' do
  connect node['ace-stunnel']['connect']
  accept node['ace-stunnel']['accept']
  notifies :restart, 'service[stunnel]'
end
