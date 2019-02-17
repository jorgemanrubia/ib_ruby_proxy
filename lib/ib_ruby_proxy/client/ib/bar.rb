# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      Bar = Struct.new(:time, :open, :high, :low, :close, :volume, :count, :wap, keyword_init: true) do
        def initialize(time: nil, open: 0, high: 0, low: 0, close: 0, volume: nil, count: 0, wap: 0)
          self.time = time
          self.open = open
          self.high = high
          self.low = low
          self.close = close
          self.volume = volume
          self.count = count
          self.wap = wap
        end

        def to_ib
          ib_object = Java::ComIbClient::Bar.new
          ib_object.time(time).to_java
          ib_object.open(open).to_java
          ib_object.high(high).to_java
          ib_object.low(low).to_java
          ib_object.close(close).to_java
          ib_object.volume(volume).to_java
          ib_object.count(count).to_java
          ib_object.wap(wap).to_java

          ib_object
        end
      end
    end
  end
end
