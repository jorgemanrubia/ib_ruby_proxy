# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      HistoricalTickLast = Struct.new(:time, :tick_attrib_last, :price, :size, :exchange, :special_conditions, keyword_init: true) do
        def initialize(time: nil, tick_attrib_last: nil, price: 0, size: nil, exchange: nil, special_conditions: nil)
          self.time = time
          self.tick_attrib_last = tick_attrib_last
          self.price = price
          self.size = size
          self.exchange = exchange
          self.special_conditions = special_conditions
        end

        def to_ib
          ib_object = Java::ComIbClient::HistoricalTickLast.new
          ib_object.time(time).to_java
          ib_object.tickAttribLast(tick_attrib_last).to_java
          ib_object.price(price).to_java
          ib_object.size(size).to_java
          ib_object.exchange(exchange).to_java
          ib_object.specialConditions(special_conditions).to_java

          ib_object
        end
      end
    end
  end
end
