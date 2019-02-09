# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      Contract = Struct.new(:conid, :symbol, :sec_type, :last_trade_date_or_contract_month, :strike, :right, :multiplier, :exchange, :primary_exch, :currency, :local_symbol, :trading_class, :sec_id_type, :sec_id, :delta_neutral_contract, :include_expired, :combo_legs_descrip, :combo_legs, keyword_init: true) do
        def initialize(conid: 0, symbol: nil, sec_type: nil, last_trade_date_or_contract_month: nil, strike: 0, right: nil, multiplier: nil, exchange: nil, primary_exch: nil, currency: nil, local_symbol: nil, trading_class: nil, sec_id_type: nil, sec_id: nil, delta_neutral_contract: nil, include_expired: false, combo_legs_descrip: nil, combo_legs: nil)
          self.conid = conid
          self.symbol = symbol
          self.sec_type = sec_type
          self.last_trade_date_or_contract_month = last_trade_date_or_contract_month
          self.strike = strike
          self.right = right
          self.multiplier = multiplier
          self.exchange = exchange
          self.primary_exch = primary_exch
          self.currency = currency
          self.local_symbol = local_symbol
          self.trading_class = trading_class
          self.sec_id_type = sec_id_type
          self.sec_id = sec_id
          self.delta_neutral_contract = delta_neutral_contract
          self.include_expired = include_expired
          self.combo_legs_descrip = combo_legs_descrip
          self.combo_legs = combo_legs
        end

        def to_ib
          ib_object = Java::ComIbClient::Contract.new
          ib_object.conid(conid).to_java
          ib_object.symbol(symbol).to_java
          ib_object.secType(sec_type).to_java
          ib_object.lastTradeDateOrContractMonth(last_trade_date_or_contract_month).to_java
          ib_object.strike(strike).to_java
          ib_object.right(right).to_java
          ib_object.multiplier(multiplier).to_java
          ib_object.exchange(exchange).to_java
          ib_object.primaryExch(primary_exch).to_java
          ib_object.currency(currency).to_java
          ib_object.localSymbol(local_symbol).to_java
          ib_object.tradingClass(trading_class).to_java
          ib_object.secIdType(sec_id_type).to_java
          ib_object.secId(sec_id).to_java
          ib_object.deltaNeutralContract(delta_neutral_contract).to_java
          ib_object.includeExpired(include_expired).to_java
          ib_object.comboLegsDescrip(combo_legs_descrip).to_java
          ib_object.comboLegs(combo_legs).to_java

          ib_object
        end
      end
    end
  end
end
