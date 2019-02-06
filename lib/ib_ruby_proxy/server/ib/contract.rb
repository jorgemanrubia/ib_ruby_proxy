# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

java_import "com.ib.client.Contract"

class Java::ComIbClient::Contract
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::Contract.new
    ruby_object.conid = conid()
    ruby_object.symbol = symbol()
    ruby_object.sec_type = secType()
    ruby_object.last_trade_date_or_contract_month = lastTradeDateOrContractMonth()
    ruby_object.strike = strike()
    ruby_object.right = right()
    ruby_object.multiplier = multiplier()
    ruby_object.exchange = exchange()
    ruby_object.primary_exch = primaryExch()
    ruby_object.currency = currency()
    ruby_object.local_symbol = localSymbol()
    ruby_object.trading_class = tradingClass()
    ruby_object.sec_id_type = secIdType()
    ruby_object.sec_id = secId()
    ruby_object.delta_neutral_contract = deltaNeutralContract()
    ruby_object.include_expired = includeExpired()
    ruby_object.combo_legs_descrip = comboLegsDescrip()
    ruby_object.combo_legs = comboLegs()

    ruby_object
  end
end
