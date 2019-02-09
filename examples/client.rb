require 'drb'
require 'ib_ruby_proxy'

client = DRbObject.new(nil, "druby://localhost:1992")
DRb.start_service

class MyWrapper < IbRubyProxy::Client::IbCallbacksWrapper
  # def method_missing(m, *args, &block)
  #   puts "There's no method called #{m} here -- please try again."
  # end
end


def emini
  contract = IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                                   sec_type: 'FUT',
                                                   currency: 'USD',
                                                   exchange: 'GLOBEX',
                                                   last_trade_date_or_contract_month: '201903'
  contract
end

client.add_ib_callbacks_wrapper MyWrapper.new
client.req_historical_ticks(18001, emini, "20190125 21:39:33", nil, 100, "TRADES", 1, false, nil)
