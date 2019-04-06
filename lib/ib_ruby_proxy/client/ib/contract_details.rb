# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      ContractDetails = Struct.new(:contract, :market_name, :min_tick, :price_magnifier, :order_types, :valid_exchanges, :under_conid, :long_name, :contract_month, :industry, :category, :subcategory, :time_zone_id, :trading_hours, :liquid_hours, :ev_rule, :ev_multiplier, :md_size_multiplier, :sec_id_list, :agg_group, :under_symbol, :under_sec_type, :market_rule_ids, :real_expiration_date, :last_trade_time, :cusip, :ratings, :desc_append, :bond_type, :coupon_type, :callable, :putable, :coupon, :convertible, :maturity, :issue_date, :next_option_date, :next_option_type, :next_option_partial, :notes, keyword_init: true) do
        def initialize(contract: nil, market_name: nil, min_tick: 0, price_magnifier: 0, order_types: nil, valid_exchanges: nil, under_conid: 0, long_name: nil, contract_month: nil, industry: nil, category: nil, subcategory: nil, time_zone_id: nil, trading_hours: nil, liquid_hours: nil, ev_rule: nil, ev_multiplier: 0, md_size_multiplier: 0, sec_id_list: nil, agg_group: 0, under_symbol: nil, under_sec_type: nil, market_rule_ids: nil, real_expiration_date: nil, last_trade_time: nil, cusip: nil, ratings: nil, desc_append: nil, bond_type: nil, coupon_type: nil, callable: false, putable: false, coupon: 0, convertible: false, maturity: nil, issue_date: nil, next_option_date: nil, next_option_type: nil, next_option_partial: false, notes: nil)
          self.contract = contract
          self.market_name = market_name
          self.min_tick = min_tick
          self.price_magnifier = price_magnifier
          self.order_types = order_types
          self.valid_exchanges = valid_exchanges
          self.under_conid = under_conid
          self.long_name = long_name
          self.contract_month = contract_month
          self.industry = industry
          self.category = category
          self.subcategory = subcategory
          self.time_zone_id = time_zone_id
          self.trading_hours = trading_hours
          self.liquid_hours = liquid_hours
          self.ev_rule = ev_rule
          self.ev_multiplier = ev_multiplier
          self.md_size_multiplier = md_size_multiplier
          self.sec_id_list = sec_id_list
          self.agg_group = agg_group
          self.under_symbol = under_symbol
          self.under_sec_type = under_sec_type
          self.market_rule_ids = market_rule_ids
          self.real_expiration_date = real_expiration_date
          self.last_trade_time = last_trade_time
          self.cusip = cusip
          self.ratings = ratings
          self.desc_append = desc_append
          self.bond_type = bond_type
          self.coupon_type = coupon_type
          self.callable = callable
          self.putable = putable
          self.coupon = coupon
          self.convertible = convertible
          self.maturity = maturity
          self.issue_date = issue_date
          self.next_option_date = next_option_date
          self.next_option_type = next_option_type
          self.next_option_partial = next_option_partial
          self.notes = notes
        end

        def to_ib
          ib_object = Java::ComIbClient::ContractDetails.new
          ib_object.contract(contract).to_java
          ib_object.marketName(market_name).to_java
          ib_object.minTick(min_tick).to_java
          ib_object.priceMagnifier(price_magnifier).to_java
          ib_object.orderTypes(order_types).to_java
          ib_object.validExchanges(valid_exchanges).to_java
          ib_object.underConid(under_conid).to_java
          ib_object.longName(long_name).to_java
          ib_object.contractMonth(contract_month).to_java
          ib_object.industry(industry).to_java
          ib_object.category(category).to_java
          ib_object.subcategory(subcategory).to_java
          ib_object.timeZoneId(time_zone_id).to_java
          ib_object.tradingHours(trading_hours).to_java
          ib_object.liquidHours(liquid_hours).to_java
          ib_object.evRule(ev_rule).to_java
          ib_object.evMultiplier(ev_multiplier).to_java
          ib_object.mdSizeMultiplier(md_size_multiplier).to_java
          ib_object.secIdList(sec_id_list).to_java
          ib_object.aggGroup(agg_group).to_java
          ib_object.underSymbol(under_symbol).to_java
          ib_object.underSecType(under_sec_type).to_java
          ib_object.marketRuleIds(market_rule_ids).to_java
          ib_object.realExpirationDate(real_expiration_date).to_java
          ib_object.lastTradeTime(last_trade_time).to_java
          ib_object.cusip(cusip).to_java
          ib_object.ratings(ratings).to_java
          ib_object.descAppend(desc_append).to_java
          ib_object.bondType(bond_type).to_java
          ib_object.couponType(coupon_type).to_java
          ib_object.callable(callable).to_java
          ib_object.putable(putable).to_java
          ib_object.coupon(coupon).to_java
          ib_object.convertible(convertible).to_java
          ib_object.maturity(maturity).to_java
          ib_object.issueDate(issue_date).to_java
          ib_object.nextOptionDate(next_option_date).to_java
          ib_object.nextOptionType(next_option_type).to_java
          ib_object.nextOptionPartial(next_option_partial).to_java
          ib_object.notes(notes).to_java

          ib_object
        end
      end
    end
  end
end
