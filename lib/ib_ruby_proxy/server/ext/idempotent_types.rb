java_import "java.lang.Enum"

module IbRubyProxy
  module Server
    module Ext
      module IdempotentType
        def to_ib
          self
        end

        def to_ruby
          self
        end
      end
    end
  end
end

[String, Integer, Float, NilClass, TrueClass, FalseClass, Enum].each do |klass|
  klass.include IbRubyProxy::Server::Ext::IdempotentType
end
