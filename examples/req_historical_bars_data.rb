require_relative './common'

client = IbRubyProxy::Client::Client.from_drb

client.req_historical_data(18009, Securities.emini, '20190304 17:00:01', '1 M', '1 day',
                           'TRADES', 1, 1, false, nil) do |_callback, _request_id, bar|
  ap bar
end

sleep
