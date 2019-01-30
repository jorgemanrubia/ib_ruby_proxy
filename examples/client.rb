require 'drb'
require 'ib_ruby_proxy'

class MyObserver
  include DRbUndumped

  def update(*notifications)
    puts "checking notifications ..."
    notifications.each do |n|
      puts n.message
    end
  end
end

client = DRbObject.new(nil, "druby://localhost:1992")
DRb.start_service


def emini
  contract = IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                                   sec_type: 'FUT',
                                                   currency: 'USD',
                                                   exchange: 'GLOBEX',
                                                   last_trade_date_or_contract_month: '201903'
  contract
end

puts client.req_historical_ticks(18001, emini, "20190125 21:39:33", nil, 100, "TRADES", 1, false, nil)
