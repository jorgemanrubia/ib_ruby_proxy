require_relative './common'

client = IbRubyProxy::Client::Client.from_drb


client.req_tick_by_tick_data(18002, Securities.emini, 'Last', 0, false) do |*arguments|
  ap arguments
end

sleep
