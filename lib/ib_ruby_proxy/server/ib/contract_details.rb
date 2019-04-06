# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

java_import "com.ib.client.ContractDetails"

class Java::ComIbClient::ContractDetails
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::ContractDetails.new
    ruby_object.contract = contract().to_ruby
    ruby_object.market_name = marketName().to_ruby
    ruby_object.min_tick = minTick().to_ruby
    ruby_object.price_magnifier = priceMagnifier().to_ruby
    ruby_object.order_types = orderTypes().to_ruby
    ruby_object.valid_exchanges = validExchanges().to_ruby
    ruby_object.under_conid = underConid().to_ruby
    ruby_object.long_name = longName().to_ruby
    ruby_object.contract_month = contractMonth().to_ruby
    ruby_object.industry = industry().to_ruby
    ruby_object.category = category().to_ruby
    ruby_object.subcategory = subcategory().to_ruby
    ruby_object.time_zone_id = timeZoneId().to_ruby
    ruby_object.trading_hours = tradingHours().to_ruby
    ruby_object.liquid_hours = liquidHours().to_ruby
    ruby_object.ev_rule = evRule().to_ruby
    ruby_object.ev_multiplier = evMultiplier().to_ruby
    ruby_object.md_size_multiplier = mdSizeMultiplier().to_ruby
    ruby_object.sec_id_list = secIdList().to_ruby
    ruby_object.agg_group = aggGroup().to_ruby
    ruby_object.under_symbol = underSymbol().to_ruby
    ruby_object.under_sec_type = underSecType().to_ruby
    ruby_object.market_rule_ids = marketRuleIds().to_ruby
    ruby_object.real_expiration_date = realExpirationDate().to_ruby
    ruby_object.last_trade_time = lastTradeTime().to_ruby
    ruby_object.cusip = cusip().to_ruby
    ruby_object.ratings = ratings().to_ruby
    ruby_object.desc_append = descAppend().to_ruby
    ruby_object.bond_type = bondType().to_ruby
    ruby_object.coupon_type = couponType().to_ruby
    ruby_object.callable = callable().to_ruby
    ruby_object.putable = putable().to_ruby
    ruby_object.coupon = coupon().to_ruby
    ruby_object.convertible = convertible().to_ruby
    ruby_object.maturity = maturity().to_ruby
    ruby_object.issue_date = issueDate().to_ruby
    ruby_object.next_option_date = nextOptionDate().to_ruby
    ruby_object.next_option_type = nextOptionType().to_ruby
    ruby_object.next_option_partial = nextOptionPartial().to_ruby
    ruby_object.notes = notes().to_ruby

    ruby_object
  end
end
