require_relative './common'

client = IbRubyProxy::Client::Client.from_drb

client.req_positions do |*arguments|
  ap arguments
end

sleep

