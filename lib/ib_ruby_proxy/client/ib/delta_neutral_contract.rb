# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      DeltaNeutralContract = Struct.new(:conid, :delta, :price, keyword_init: true) do
        def initialize(conid: 0, delta: 0, price: 0)
          self.conid = conid
          self.delta = delta
          self.price = price
        end

        def to_ib
          ib_object = Java::ComIbClient::DeltaNeutralContract.new
          ib_object.conid(conid).to_java
          ib_object.delta(delta).to_java
          ib_object.price(price).to_java

          ib_object
        end
      end
    end
  end
end
