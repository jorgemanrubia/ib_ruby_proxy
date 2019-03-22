# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      HistoricalTick = Struct.new(:time, :price, :size, keyword_init: true) do
        def initialize(time: nil, price: 0, size: nil)
          self.time = time
          self.price = price
          self.size = size
        end

        def to_ib
          ib_object = Java::ComIbClient::HistoricalTick.new
          ib_object.time(time).to_java
          ib_object.price(price).to_java
          ib_object.size(size).to_java

          ib_object
        end
      end
    end
  end
end
