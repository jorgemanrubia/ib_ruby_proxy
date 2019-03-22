# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      HistoricalTickBidAsk = Struct.new(:time, :tick_attrib_bid_ask, :price_bid, :price_ask, :size_bid, :size_ask, keyword_init: true) do
        def initialize(time: nil, tick_attrib_bid_ask: nil, price_bid: 0, price_ask: 0, size_bid: nil, size_ask: nil)
          self.time = time
          self.tick_attrib_bid_ask = tick_attrib_bid_ask
          self.price_bid = price_bid
          self.price_ask = price_ask
          self.size_bid = size_bid
          self.size_ask = size_ask
        end

        def to_ib
          ib_object = Java::ComIbClient::HistoricalTickBidAsk.new
          ib_object.time(time).to_java
          ib_object.tickAttribBidAsk(tick_attrib_bid_ask).to_java
          ib_object.priceBid(price_bid).to_java
          ib_object.priceAsk(price_ask).to_java
          ib_object.sizeBid(size_bid).to_java
          ib_object.sizeAsk(size_ask).to_java

          ib_object
        end
      end
    end
  end
end
