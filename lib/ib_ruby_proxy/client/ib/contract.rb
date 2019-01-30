module IbRubyProxy
  module Client
    module Ib
      Contract = Struct.new(:symbol, :sec_type, :currency, :exchange, :last_trade_date_or_contract_month, keyword_init: true)
    end
  end
end
