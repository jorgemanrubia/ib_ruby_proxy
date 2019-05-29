require_relative './common'

client = IbRubyProxy::Client::Client.from_drb

client.req_account_updates(true, 'DU203911') do |*arguments|
  ap arguments
end

sleep

