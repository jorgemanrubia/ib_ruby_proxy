require 'drb'
require 'ib_ruby_proxy'

class Securities
  class << self
    def emini(expiration_month = '201906')
      IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                            sec_type: 'FUT',
                                            currency: 'USD',
                                            exchange: 'GLOBEX',
                                            last_trade_date_or_contract_month: expiration_month
    end
  end
end

