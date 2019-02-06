java_import 'java.util.ArrayList'

module IbRubyProxy
  module Server
    module Ext
      module Array
        def to_ib
          collect(&:to_ib)
        end

        def to_ruby
          collect(&:to_ruby)
        end
      end
    end
  end
end

[Array, Java::JavaUtil::ArrayList].each do |array_klass|
  array_klass.send(:include, IbRubyProxy::Server::Ext::Array)
end
