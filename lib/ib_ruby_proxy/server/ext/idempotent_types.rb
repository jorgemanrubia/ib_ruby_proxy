java_import 'java.lang.Enum'
java_import 'java.lang.Throwable'

module IbRubyProxy
  module Server
    module Ext
      # Extension to convert between ib and ruby for types that can travel seamlessly
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

[String, Integer, Float, NilClass, TrueClass, FalseClass, Throwable].each do |klass|
  klass.include IbRubyProxy::Server::Ext::IdempotentType
end
