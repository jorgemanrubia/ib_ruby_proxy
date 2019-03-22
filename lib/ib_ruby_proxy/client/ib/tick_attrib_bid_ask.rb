# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      TickAttribBidAsk = Struct.new(:bid_past_low, :ask_past_high, keyword_init: true) do
        def initialize(bid_past_low: false, ask_past_high: false)
          self.bid_past_low = bid_past_low
          self.ask_past_high = ask_past_high
        end

        def to_ib
          ib_object = Java::ComIbClient::TickAttribBidAsk.new
          ib_object.bidPastLow(bid_past_low).to_java
          ib_object.askPastHigh(ask_past_high).to_java

          ib_object
        end
      end
    end
  end
end
