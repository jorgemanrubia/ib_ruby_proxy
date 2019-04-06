java_import 'java.lang.Enum'

module IbRubyProxy
  module Server
    module Ext
      module Enum
        def to_ib
          self
        end

        def to_ruby
          to_s
        end
      end
    end
  end
end

Java::JavaLang::Enum.send(:include, IbRubyProxy::Server::Ext::Enum)
