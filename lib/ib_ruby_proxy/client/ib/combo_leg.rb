# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

class Java::ComIbClient::ComboLeg
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::ComboLeg.new
    ruby_object.conid = conid
    ruby_object.ratio = ratio
    ruby_object.action = action
    ruby_object.exchange = exchange
    ruby_object.open_close = openClose
    ruby_object.short_sale_slot = shortSaleSlot
    ruby_object.designated_location = designatedLocation
    ruby_object.exempt_code = exemptCode

    ruby_object
  end
end

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
          ib_object.conid(conid)
          ib_object.ratio(ratio)
          ib_object.action(action)
          ib_object.exchange(exchange)
          ib_object.openClose(open_close)
          ib_object.shortSaleSlot(short_sale_slot)
          ib_object.designatedLocation(designated_location)
          ib_object.exemptCode(exempt_code)

          ib_object
        end
      end
    end
  end
end
