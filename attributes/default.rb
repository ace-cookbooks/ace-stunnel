default['ace-stunnel']['connect'] = nil
default['ace-stunnel']['accept'] = nil
default['ace-stunnel']['cert'] = nil
default['ace-stunnel']['key'] = nil
default['ace-stunnel']['cafile'] = nil

force_default['stunnel']['global']['foreground'] = 'no'
force_default['stunnel']['global']['pid'] = '/var/run/stunnel/stunnel.pid'
force_default['stunnel']['global']['output'] = '/var/log/stunnel/stunnel.log'
