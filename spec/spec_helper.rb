require 'juicer'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)
HTTPI.log = false
