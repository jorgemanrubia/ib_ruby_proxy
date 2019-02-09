# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

module IbRubyProxy
  module Client
    module Ib
      TickAttribLast = Struct.new(:past_limit, :unreported, keyword_init: true) do
        def initialize(past_limit: false, unreported: false)
          self.past_limit = past_limit
          self.unreported = unreported
        end

        def to_ib
          ib_object = Java::ComIbClient::TickAttribLast.new
          ib_object.pastLimit(past_limit).to_java
          ib_object.unreported(unreported).to_java

          ib_object
        end
      end
    end
  end
end
