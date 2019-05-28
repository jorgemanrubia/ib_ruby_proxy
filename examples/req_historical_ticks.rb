require_relative './common'

client = IbRubyProxy::Client::Client.from_drb

promise = client.req_historical_ticks(18009, Securities.emini, nil, "20190304 17:00:01", 100, "MIDPOINT", 1, false, nil).then do |id, ticks, done|
  ap ticks
end

promise.value # block until promise resolved





