# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

class Java::ComIbClient::Contract
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::Contract.new
    ruby_object.conid = conid
    ruby_object.symbol = symbol
    ruby_object.sec_type = secType
    ruby_object.last_trade_date_or_contract_month = lastTradeDateOrContractMonth
    ruby_object.strike = strike
    ruby_object.right = right
    ruby_object.multiplier = multiplier
    ruby_object.exchange = exchange
    ruby_object.primary_exch = primaryExch
    ruby_object.currency = currency
    ruby_object.local_symbol = localSymbol
    ruby_object.trading_class = tradingClass
    ruby_object.sec_id_type = secIdType
    ruby_object.sec_id = secId
    ruby_object.delta_neutral_contract = deltaNeutralContract
    ruby_object.include_expired = includeExpired
    ruby_object.combo_legs_descrip = comboLegsDescrip
    ruby_object.combo_legs = comboLegs

    ruby_object
  end
end

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
          ib_object.conid(conid)
          ib_object.symbol(symbol)
          ib_object.secType(sec_type)
          ib_object.lastTradeDateOrContractMonth(last_trade_date_or_contract_month)
          ib_object.strike(strike)
          ib_object.right(right)
          ib_object.multiplier(multiplier)
          ib_object.exchange(exchange)
          ib_object.primaryExch(primary_exch)
          ib_object.currency(currency)
          ib_object.localSymbol(local_symbol)
          ib_object.tradingClass(trading_class)
          ib_object.secIdType(sec_id_type)
          ib_object.secId(sec_id)
          ib_object.deltaNeutralContract(delta_neutral_contract)
          ib_object.includeExpired(include_expired)
          ib_object.comboLegsDescrip(combo_legs_descrip)
          ib_object.comboLegs(combo_legs)

          ib_object
        end
      end
    end
  end
end
