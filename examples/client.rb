require 'drb'
require 'ib_ruby_proxy'

client = IbRubyProxy::Client::Client.from_drb

def emini
  IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                        sec_type: 'FUT',
                                        currency: 'USD',
                                        exchange: 'GLOBEX',
                                        last_trade_date_or_contract_month: '201906'
end

promise = client.req_historical_ticks(18009, emini, nil, "20190304 17:00:01", 100, "TRADES", 1, false, nil).then do |id, ticks, done|
  ap ticks
end

promise.value # block until promise resolved

