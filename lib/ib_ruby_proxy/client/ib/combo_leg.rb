# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      ComboLeg = Struct.new(:conid, :ratio, :action, :exchange, :open_close, :short_sale_slot, :designated_location, :exempt_code, keyword_init: true) do
        def initialize(conid: 0, ratio: 0, action: nil, exchange: nil, open_close: 0, short_sale_slot: 0, designated_location: nil, exempt_code: 0)
          self.conid = conid
          self.ratio = ratio
          self.action = action
          self.exchange = exchange
          self.open_close = open_close
          self.short_sale_slot = short_sale_slot
          self.designated_location = designated_location
          self.exempt_code = exempt_code
        end

        def to_ib
          ib_object = Java::ComIbClient::ComboLeg.new
          ib_object.conid(conid).to_java
          ib_object.ratio(ratio).to_java
          ib_object.action(action).to_java
          ib_object.exchange(exchange).to_java
          ib_object.openClose(open_close).to_java
          ib_object.shortSaleSlot(short_sale_slot).to_java
          ib_object.designatedLocation(designated_location).to_java
          ib_object.exemptCode(exempt_code).to_java

          ib_object
        end
      end
    end
  end
end
