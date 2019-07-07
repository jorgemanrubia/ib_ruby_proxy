module Test
  module Securities
    extend self

    def emini
      IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                            sec_type: 'FUT',
                                            currency: 'USD',
                                            exchange: 'GLOBEX',
                                            last_trade_date_or_contract_month: '201909'
    end
  end
end
