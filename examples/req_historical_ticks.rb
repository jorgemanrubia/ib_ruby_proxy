require_relative './common'

client = IbRubyProxy::Client::Client.from_drb

client.req_historical_ticks(18009, Securities.emini, nil, "20190304 17:00:01", 100, "MIDPOINT", 1, false, nil) do |_callback, _request_id, ticks, done|
  ap ticks
end

sleep





