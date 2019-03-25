require 'drb'
require 'ib_ruby_proxy'
require 'concurrent-ruby'

client = IbRubyProxy::Client::Client.new

class MyWrapper < IbRubyProxy::Client::IbCallbacksWrapper
  def error(*arguments)
    puts "ERROR RECEIVED"
    ap arguments
  end

  def historical_ticks_last(*arguments)
    puts "HISTORICAL!!!"
    puts arguments.inspect
  end
end


def emini
  contract = IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                                   sec_type: 'FUT',
                                                   currency: 'USD',
                                                   exchange: 'GLOBEX',
                                                   last_trade_date_or_contract_month: '201906'
  contract
end

# client.add_ib_callbacks_wrapper MyWrapper.new
promise = client.req_historical_ticks(18004, emini, "20190320 21:39:33", nil, 100, "TRADES", 1, false, nil)
promise.then do |id, ticks, done|
  puts "PROMISE RESOLVED"
  ap ticks
end

sleep
