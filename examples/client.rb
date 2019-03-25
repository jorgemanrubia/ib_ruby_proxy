require 'drb'
require 'ib_ruby_proxy'
require 'concurrent-ruby'

client = IbRubyProxy::Client::Client.new

def emini
  IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                        sec_type: 'FUT',
                                        currency: 'USD',
                                        exchange: 'GLOBEX',
                                        last_trade_date_or_contract_month: '201906'
end

client.req_historical_ticks(18004, emini, "20190320 21:39:33", nil, 100, "TRADES", 1, false, nil).then do |id, ticks, done|
  ap ticks
end

promise.value # block until promise resolved

