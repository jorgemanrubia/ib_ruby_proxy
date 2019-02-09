# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

java_import "com.ib.client.Contract"

class Java::ComIbClient::Contract
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::Contract.new
    ruby_object.conid = conid().to_ruby
    ruby_object.symbol = symbol().to_ruby
    ruby_object.sec_type = secType().to_ruby
    ruby_object.last_trade_date_or_contract_month = lastTradeDateOrContractMonth().to_ruby
    ruby_object.strike = strike().to_ruby
    ruby_object.right = right().to_ruby
    ruby_object.multiplier = multiplier().to_ruby
    ruby_object.exchange = exchange().to_ruby
    ruby_object.primary_exch = primaryExch().to_ruby
    ruby_object.currency = currency().to_ruby
    ruby_object.local_symbol = localSymbol().to_ruby
    ruby_object.trading_class = tradingClass().to_ruby
    ruby_object.sec_id_type = secIdType().to_ruby
    ruby_object.sec_id = secId().to_ruby
    ruby_object.delta_neutral_contract = deltaNeutralContract().to_ruby
    ruby_object.include_expired = includeExpired().to_ruby
    ruby_object.combo_legs_descrip = comboLegsDescrip().to_ruby
    ruby_object.combo_legs = comboLegs().to_ruby

    ruby_object
  end
end
