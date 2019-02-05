# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

class Java::ComIbClient::DeltaNeutralContract
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::DeltaNeutralContract.new
    ruby_object.conid = conid
    ruby_object.delta = delta
    ruby_object.price = price

    ruby_object
  end
end

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
          ib_object.conid(conid)
          ib_object.delta(delta)
          ib_object.price(price)

          ib_object
        end
      end
    end
  end
end
