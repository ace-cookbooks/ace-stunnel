include_recipe 'eye'

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

include_recipe 'simply-stunnel'
