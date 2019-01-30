require 'drb'
require 'ostruct'

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

# Java: org.foo.department.Widget
# Ruby: Java::OrgFooDepartment::Widget

# com.ib.client.Contract
# ComIbClient
#

module Java
  module ComIbClient
    # Contract = Struct.new(:m_symbol, :m_sectType, :m_currency, :m_exchange, :m_lastTradeDateOrContractMonth) do
    # end
    
    class Contract
      attr_accessor :m_symbol, :m_sectType, :m_currency, :m_exchange, :m_lastTradeDateOrContractMonth
      
      def initialize(m_symbol: nil, m_sectType: nil, m_currency: nil, m_exchange: nil, m_lastTradeDateOrContractMonth: nil)
        @m_symbol = m_symbol
        @m_sectType = m_sectType
        @m_currency = m_currency
        @m_exchange = m_exchange
        @m_lastTradeDateOrContractMonth = m_lastTradeDateOrContractMonth
      end
    end
  end
end


def emini
  contract = Java::ComIbClient::Contract.new(m_symbol: 'ES',
                          m_sectType: 'FUT',
                          m_currency: 'USD',
                          m_exchange: 'GLOBEX',
                          m_lastTradeDateOrContractMonth: '201903')
  # contract.symbol("ES");
  # contract.secType("FUT");
  # contract.currency("USD");
  # contract.exchange("GLOBEX");
  # contract.lastTradeDateOrContractMonth("201903");
  contract
end

puts client.reqHistoricalTicks(18001, emini, "20190125 21:39:33", nil, 100, "TRADES", 1, false, nil)

